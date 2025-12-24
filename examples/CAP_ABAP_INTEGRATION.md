# Examples: CAP and ABAP Integration

This directory contains practical examples of integrating CAP with ABAP systems.

## Example 1: Consuming ABAP OData Service in CAP

### Step 1: Import the ABAP OData Service

```bash
# Import service metadata
cds import https://your-sap-system.com/sap/opu/odata/sap/API_BUSINESS_PARTNER/$metadata \
  --as cds \
  --out srv/external/API_BUSINESS_PARTNER
```

### Step 2: Configure the External Service

Add to `package.json`:

```json
{
  "cds": {
    "requires": {
      "API_BUSINESS_PARTNER": {
        "kind": "odata-v2",
        "model": "srv/external/API_BUSINESS_PARTNER",
        "credentials": {
          "url": "https://your-sap-system.com/sap/opu/odata/sap/API_BUSINESS_PARTNER",
          "authentication": "BasicAuthentication",
          "username": "{{env.ABAP_USER}}",
          "password": "{{env.ABAP_PASSWORD}}"
        }
      }
    }
  }
}
```

### Step 3: Use in CAP Service

```javascript
// srv/business-partner-service.cds
using { API_BUSINESS_PARTNER as external } from './external/API_BUSINESS_PARTNER';

service BusinessPartnerService {
  @readonly entity BusinessPartners as projection on external.A_BusinessPartner;
}

// srv/business-partner-service.js
const cds = require('@sap/cds');

module.exports = async function() {
  const BPService = await cds.connect.to('API_BUSINESS_PARTNER');
  
  this.on('READ', 'BusinessPartners', async (req) => {
    return BPService.run(req.query);
  });
}
```

## Example 2: Creating OData Service in ABAP (RAP)

### Define CDS View

```abap
@EndUserText.label: 'Product View'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZI_Product
  as select from zproduct
{
  key product_id as ProductId,
      name as Name,
      description as Description,
      price as Price,
      currency as Currency,
      stock as Stock
}
```

### Create Behavior Definition

```abap
managed implementation in class zbp_i_product unique;

define behavior for ZI_Product alias Product
{
  use create;
  use update;
  use delete;
  
  field ( readonly ) ProductId;
  
  validation validatePrice on save
  {
    field Price;
  }
}
```

### Expose as Service

```abap
@EndUserText.label: 'Product Service'
define service Z_PRODUCT_SRV
{
  expose ZI_Product as Product;
}
```

## Example 3: Side-by-Side Extension

### Architecture
```
┌─────────────────┐         ┌──────────────────┐
│   CAP on BTP    │◄────────│  SAP S/4HANA     │
│   (Extension)   │  Cloud  │   (ABAP Core)    │
│                 │ Connect │                  │
└─────────────────┘         └──────────────────┘
```

### CAP Extension Service

```javascript
// Extend ABAP business partner with custom fields
service ExtendedBPService {
  entity BusinessPartners as projection on ABAP.BusinessPartner {
    *,
    // Add custom fields
    loyaltyPoints: Integer,
    preferredContact: String,
    customNotes: String
  };
}

// Store extension data in CAP/HANA
entity BPExtension {
  key businessPartnerId: String;
  loyaltyPoints: Integer;
  preferredContact: String;
  customNotes: String;
}
```

## Example 4: Event-Driven Integration

### ABAP: Publishing Events

```abap
CLASS zcl_event_publisher DEFINITION.
  PUBLIC SECTION.
    METHODS publish_product_created
      IMPORTING iv_product_id TYPE string
                iv_name TYPE string.
ENDCLASS.

CLASS zcl_event_publisher IMPLEMENTATION.
  METHOD publish_product_created.
    " Use SAP Event Mesh to publish event
    DATA(lo_event) = cl_event_factory=>create_event(
      iv_event_type = 'sap.s4.product.created.v1'
    ).
    
    lo_event->set_data( VALUE #(
      productId = iv_product_id
      name = iv_name
    ) ).
    
    lo_event->publish( ).
  ENDMETHOD.
ENDCLASS.
```

### CAP: Subscribing to Events

```javascript
const cds = require('@sap/cds');

module.exports = async function() {
  const messaging = await cds.connect.to('messaging');
  
  messaging.on('sap.s4.product.created.v1', async (msg) => {
    console.log('New product created in S/4HANA:', msg.data);
    
    // Sync to local database
    const { Products } = cds.entities;
    await INSERT.into(Products).entries({
      ID: msg.data.productId,
      name: msg.data.name,
      sourceSystem: 'S4HANA'
    });
  });
}
```

## Example 5: Authentication Flow

### Configure Destination in BTP

```json
{
  "Name": "S4HANA_BACKEND",
  "Type": "HTTP",
  "URL": "https://your-s4hana.com",
  "ProxyType": "OnPremise",
  "Authentication": "PrincipalPropagation",
  "CloudConnectorLocationId": "your-location-id"
}
```

### Use in CAP Service

```javascript
const cds = require('@sap/cds');

module.exports = async function() {
  const S4Service = await cds.connect.to('S4HANA_BACKEND');
  
  this.on('READ', 'SalesOrders', async (req) => {
    // User context is automatically propagated
    return S4Service.run(req.query);
  });
}
```

## Best Practices

1. **Connection Pooling**: Reuse connections to ABAP systems
2. **Caching**: Cache frequently accessed ABAP data in CAP
3. **Error Handling**: Map ABAP errors to OData error format
4. **Monitoring**: Log all integration points
5. **Testing**: Mock ABAP services for local testing

## Resources

- [CAP Remote Services](https://cap.cloud.sap/docs/guides/using-services)
- [RAP Developer Guide](https://help.sap.com/docs/ABAP_PLATFORM_NEW/fc4c71aa50014fd1b43721701471913d/289477a81eec4d4e84c0302fb6835035.html)
- [SAP Event Mesh](https://help.sap.com/docs/SAP_ENTERPRISE_MESSAGING)
