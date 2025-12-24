# CAP Project

This directory contains the Cloud Application Programming Model (CAP) project structure.

## Directory Structure

- **db/** - Database models and schema definitions (CDS files)
- **srv/** - Service definitions and implementations
- **app/** - UI applications (Fiori apps, etc.)

## Getting Started

### Prerequisites

- Node.js (>= 18.x)
- SAP Cloud Application Programming Model CLI

### Installation

```bash
# Install dependencies
npm install

# Install CDS development tools globally (optional)
npm install -g @sap/cds-dk
```

### Development

```bash
# Start the CAP server in watch mode
npm run watch

# Or use cds directly
cds watch
```

### Build

```bash
# Build for production
npm run build
```

### Deploy

```bash
# Deploy to SAP HANA (requires configuration)
npm run deploy
```

## Key Concepts

### Data Models (db/schema.cds)
Define your database entities using CDS syntax. The schema includes:
- **Books** - Sample entity for learning CAP basics
- **Courses** - Sample entity for course management

### Services (srv/)
Services expose your data models via OData APIs:
- **CatalogService** - Main service for Books and Courses

### Custom Logic
Service implementations (*.js files) allow you to add custom business logic:
- Event handlers (before/after/on)
- Custom actions and functions
- Validation and authorization

## Resources

- [SAP CAP Documentation](https://cap.cloud.sap/docs/)
- [CDS Language Reference](https://cap.cloud.sap/docs/cds/)
- [CAP Samples](https://github.com/SAP-samples/cloud-cap-samples)
