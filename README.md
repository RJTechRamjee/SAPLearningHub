# SAP Learning Hub

A comprehensive learning repository supporting both **SAP Cloud Application Programming Model (CAP)** and **ABAP** development.

## 🎯 Overview

This repository is designed to help developers learn and work with both modern cloud-native SAP development (CAP) and traditional ABAP programming. It provides:

- ✅ Complete CAP project structure with sample code
- ✅ ABAP project structure with examples
- ✅ Integration patterns between CAP and ABAP
- ✅ Learning guides and best practices
- ✅ Development environment configuration

## 📁 Repository Structure

```
SAPLearningHub/
├── cap-project/              # SAP Cloud Application Programming Model
│   ├── db/                   # Data models and schemas (CDS)
│   ├── srv/                  # Service definitions and implementations
│   ├── app/                  # UI applications (Fiori, etc.)
│   └── README.md            # CAP-specific documentation
│
├── abap-project/            # ABAP Development
│   ├── src/                 # ABAP source code (classes, programs)
│   ├── docs/                # ABAP learning materials
│   └── README.md           # ABAP-specific documentation
│
├── package.json            # Node.js dependencies for CAP
├── mta.yaml               # Multi-target application descriptor
├── GETTING_STARTED.md     # Quick start guide
└── INTEGRATION.md         # CAP-ABAP integration patterns
```

## 🚀 Quick Start

### Prerequisites

**For CAP Development:**
- Node.js (>= 18.x)
- npm or yarn
- SAP CDS CLI (optional but recommended)

**For ABAP Development:**
- SAP system access (NetWeaver or S/4HANA)
- ABAP Development Tools (ADT) in Eclipse
- Or SAP Business Application Studio

### Installation

```bash
# Clone the repository
git clone https://github.com/RJTechRamjee/SAPLearningHub.git
cd SAPLearningHub

# Install CAP dependencies
npm install

# Start CAP development server
npm run watch
```

For detailed setup instructions, see [GETTING_STARTED.md](./GETTING_STARTED.md)

## 📚 What's Inside

### CAP Project

The CAP project includes:
- **Data Models**: CDS schema definitions for Books and Courses
- **Services**: OData services with custom business logic
- **Sample Code**: Event handlers and service implementations
- **MTA Configuration**: Deployment descriptor for SAP BTP

Learn more in [cap-project/README.md](./cap-project/README.md)

### ABAP Project

The ABAP project includes:
- **Sample Programs**: Hello World and basic ABAP examples
- **Classes**: Object-oriented ABAP examples
- **Learning Guide**: Comprehensive ABAP tutorial
- **Best Practices**: Modern ABAP and clean code principles

Learn more in [abap-project/README.md](./abap-project/README.md)

### Integration

Learn how to integrate CAP and ABAP:
- Consuming ABAP OData services in CAP
- RESTful ABAP Programming (RAP) integration
- Authentication and authorization patterns
- Side-by-side extension scenarios

See [INTEGRATION.md](./INTEGRATION.md) for detailed integration patterns

## 🛠️ Development

### CAP Development

```bash
# Start in watch mode (auto-reload on changes)
npm run watch

# Build for production
npm run build

# Deploy to SAP HANA
npm run deploy
```

### ABAP Development

1. Open Eclipse with ABAP Development Tools
2. Create/Link ABAP Project to your SAP system
3. Use abapGit to sync with this repository
4. Develop and test in your SAP system

### VS Code Workspace

Open `SAPLearningHub.code-workspace` in VS Code for a multi-folder workspace with:
- Separate views for CAP and ABAP projects
- Recommended extensions
- Optimized settings for SAP development

## 📖 Learning Path

### For CAP Developers

1. Start with [cap-project/README.md](./cap-project/README.md)
2. Explore the data models in `cap-project/db/`
3. Study service implementations in `cap-project/srv/`
4. Review [CAP documentation](https://cap.cloud.sap/docs/)

### For ABAP Developers

1. Start with [abap-project/README.md](./abap-project/README.md)
2. Read the [Learning Guide](./abap-project/docs/LEARNING_GUIDE.md)
3. Study sample code in `abap-project/src/`
4. Follow [Clean ABAP guidelines](https://github.com/SAP/styleguides/blob/main/clean-abap/CleanABAP.md)

### For Full-Stack SAP Developers

1. Learn both CAP and ABAP individually
2. Study [INTEGRATION.md](./INTEGRATION.md)
3. Build end-to-end applications
4. Explore side-by-side extension patterns

## 🤝 Contributing

Contributions are welcome! Whether you want to:
- Add more examples
- Improve documentation
- Fix issues
- Share learning resources

Please feel free to open issues or submit pull requests.

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🔗 Resources

### Official Documentation
- [SAP CAP Documentation](https://cap.cloud.sap/docs/)
- [ABAP Documentation](https://help.sap.com/docs/ABAP_PLATFORM)
- [SAP Business Technology Platform](https://help.sap.com/docs/BTP)

### Community
- [SAP Community](https://community.sap.com/)
- [CAP on GitHub](https://github.com/SAP/cloud-cap-samples)
- [abapGit](https://abapgit.org/)

### Courses
- [openSAP Courses](https://open.sap.com/)
- [SAP Learning Hub](https://learning.sap.com/)

## 📧 Contact

For questions or feedback, please open an issue in this repository.

---

**Happy Learning! 🎓**
