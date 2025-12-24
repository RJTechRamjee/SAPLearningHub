# CAP Applications

This directory is for SAP Fiori applications and other UI components.

## Structure

```
app/
├── fiori-apps/           # SAP Fiori Elements applications
├── freestyle-ui/         # Freestyle SAPUI5/Fiori applications
└── html5/               # HTML5 applications
```

## Creating Fiori Applications

### Using SAP Fiori Tools

```bash
# Install Fiori generator
npm install -g @sap/generator-fiori

# Generate a Fiori Elements app
yo @sap/fiori
```

### Using SAP Business Application Studio

1. Open SAP Business Application Studio
2. Use the Application Generator
3. Select template (e.g., List Report, Worklist)
4. Configure your OData service
5. Generate the application

## Integration with CAP Services

Fiori applications in this folder automatically connect to the CAP services defined in the `srv/` folder.

### Example: Consuming CatalogService

```javascript
// In your Fiori app's manifest.json
{
  "sap.app": {
    "dataSources": {
      "mainService": {
        "uri": "/catalog/",
        "type": "OData",
        "settings": {
          "odataVersion": "4.0"
        }
      }
    }
  }
}
```

## Development

```bash
# Start CAP server (from root directory)
npm run watch

# Your Fiori apps will be served at:
# http://localhost:4004/fiori-apps/<app-name>/webapp/
```

## Deployment

Fiori applications are automatically included when deploying the full MTA archive:

```bash
# Build and deploy
mbt build
cf deploy mta_archives/sap-learning-hub_1.0.0.mtar
```

## Resources

- [SAP Fiori Tools](https://help.sap.com/docs/SAP_FIORI_tools)
- [SAPUI5 Documentation](https://sapui5.hana.ondemand.com/)
- [Fiori Design Guidelines](https://experience.sap.com/fiori-design/)
