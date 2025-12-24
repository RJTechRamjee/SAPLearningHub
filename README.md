# SAP Learning Hub

A comprehensive SAP Cloud Application Programming (CAP) Model application for managing learning courses, paths, and analytics. Built with SAP Fiori Elements and ready for deployment to SAP BTP and HANA Cloud.

## 📋 Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Running Locally](#running-locally)
- [Deployment](#deployment)
- [Applications](#applications)
- [Data Model](#data-model)
- [Project Structure](#project-structure)
- [Security](#security)

## 🎯 Overview

SAP Learning Hub is a complete enterprise learning management system built using:
- **SAP Cloud Application Programming (CAP) Model** with Node.js runtime
- **OData V4** services
- **SAP Fiori Elements** for UI generation
- **SAP HANA Cloud** database (or SQLite for local development)
- **Application Router** for authentication and routing
- **Multi-Target Application (MTA)** for cloud deployment

The application manages a comprehensive catalog of learning courses, organized into categories and learning paths, with detailed analytics and reporting capabilities.

## 🏗 Architecture

```
┌─────────────────────────────────────────────────────────┐
│                  SAP BTP Cloud Foundry                  │
├─────────────────────────────────────────────────────────┤
│  ┌──────────────┐    ┌───────────────┐   ┌──────────┐  │
│  │  Approuter   │───▶│  CAP Service  │──▶│   HANA   │  │
│  │  (Gateway)   │    │   (Node.js)   │   │    DB    │  │
│  └──────────────┘    └───────────────┘   └──────────┘  │
│         │                                                │
│         ▼                                                │
│  ┌──────────────────────────────────────────┐           │
│  │    Fiori Applications (HTML5 Apps)       │           │
│  │  • List Report  • Tree View  • Analytics │           │
│  └──────────────────────────────────────────┘           │
└─────────────────────────────────────────────────────────┘
```

## ✨ Features

### Core Functionality
- **Course Catalog Management**: Comprehensive course information including pricing, duration, levels, and ratings
- **Learning Path Organization**: Structured learning journeys with sequenced courses
- **Multi-dimensional Categorization**: Categories, topics, and hierarchical organization
- **Instructor Management**: Track course instructors and their expertise
- **Module Structure**: Detailed course modules with various content types

### Three Fiori Applications

1. **List Report & Object Page** (`/app/listreport/`)
   - Browse and search courses
   - Detailed course information
   - Filtering by level, status, language, and category
   - Rating display and enrollment statistics

2. **Tree View** (`/app/treeview/`)
   - Hierarchical display of learning paths
   - Nested course structure
   - Learning path with sequenced courses
   - Module organization within courses

3. **Analytical List Page** (`/app/analytics/`)
   - KPIs: Total Courses, Enrollments, Average Rating, Learning Hours
   - Charts: Courses by Category (Bar), Courses by Level (Donut)
   - Trend Analysis: Course Releases Over Time (Line)
   - Enrollment Analysis: Enrollments by Category (Column)

## 📦 Prerequisites

- **Node.js** 18.x or 20.x
- **npm** 8.x or higher
- **SAP CDS CLI** (`@sap/cds-dk`)
- **Cloud Foundry CLI** (for deployment)
- **SAP BTP Account** (for cloud deployment)
- **HANA Cloud Instance** (for production)

## 🚀 Installation

### 1. Clone the Repository

```bash
git clone https://github.com/RJTechRamjee/SAPLearningHub.git
cd SAPLearningHub
```

### 2. Install Dependencies

```bash
# Install root dependencies
npm install

# Install Fiori app dependencies
cd app/listreport && npm install && cd ../..
cd app/treeview && npm install && cd ../..
cd app/analytics && npm install && cd ../..
cd app-router && npm install && cd ..
```

### 3. Install SAP CDS Development Kit (if not already installed)

```bash
npm install -g @sap/cds-dk
```

## 💻 Running Locally

### Start the CAP Server

```bash
cds watch
```

This will:
- Deploy the database schema to SQLite
- Load sample data from CSV files
- Start the OData V4 service at `http://localhost:4004`
- Open Fiori launchpad at `http://localhost:4004`

### Access Applications

- **Fiori Launchpad**: http://localhost:4004/
- **Course Catalog (List Report)**: http://localhost:4004/listreport/webapp/index.html
- **Learning Paths (Tree View)**: http://localhost:4004/treeview/webapp/index.html
- **Course Analytics**: http://localhost:4004/analytics/webapp/index.html
- **OData Service**: http://localhost:4004/catalog/

## 🌥 Deployment

### Deploy to SAP BTP Cloud Foundry

#### 1. Build the MTA Archive

```bash
mbt build
```

#### 2. Login to Cloud Foundry

```bash
cf login -a https://api.cf.<region>.hana.ondemand.com
```

#### 3. Deploy the Application

```bash
cf deploy mta_archives/sap-learning-hub_1.0.0.mtar
```

#### 4. Configure Role Collections

After deployment, assign role collections in BTP Cockpit:
- `SAPLearningHub_Admin` - Full administrative access
- `SAPLearningHub_Instructor` - Course management access
- `SAPLearningHub_Learner` - Read-only access

### Integration with SAP Build Workzone

1. Subscribe to SAP Build Workzone, standard edition
2. In Workzone Site Manager, create a new site
3. Add the deployed HTML5 applications to your site
4. Configure navigation and tiles as needed
5. Assign role collections to users

## 📱 Applications

### 1. Course Catalog (List Report)

**Purpose**: Browse and manage the complete course catalog

**Features**:
- Search and filter courses by multiple criteria
- View detailed course information
- See associated categories, topics, and instructors
- Review course modules and structure
- Check ratings and enrollment statistics

**Navigation**: List Report → Object Page (click on any course)

### 2. Learning Paths (Tree View)

**Purpose**: Visualize and navigate learning path hierarchies

**Features**:
- Tree/hierarchical view of learning paths
- See courses within each path
- View sequence and mandatory status
- Navigate through nested structures
- Understand learning progression

**Use Case**: Help learners understand the recommended course sequence

### 3. Course Analytics (Analytical List Page)

**Purpose**: Analyze course performance and trends

**KPIs**:
- Total Courses Count
- Total Enrollments across all courses
- Average Course Rating
- Total Learning Hours Available

**Charts**:
- Bar Chart: Courses distribution by Category
- Donut Chart: Courses by Level (Beginner/Intermediate/Advanced)
- Line Chart: Course Release Timeline
- Column Chart: Enrollment statistics by Category

**Use Case**: Strategic planning and course portfolio analysis

## 📊 Data Model

### Core Entities

- **Courses**: Main course entity with pricing, duration, rating, enrollment
- **Categories**: Hierarchical course categorization
- **LearningPaths**: Structured learning journeys
- **Topics**: Granular subject areas
- **Instructors**: Course authors and instructors
- **Modules**: Individual course modules/chapters

### Association Entities (Many-to-Many)

- **CourseCategories**: Course ↔ Categories
- **CourseTopics**: Course ↔ Topics
- **CourseInstructors**: Course ↔ Instructors
- **LearningPathCourses**: Learning Paths ↔ Courses (with sequence)

### Sample Data

The project includes comprehensive sample data:
- 15 courses across various SAP topics
- 10 categories (including hierarchical)
- 6 learning paths
- 20 topics
- 8 instructors
- 30+ modules

## 📁 Project Structure

```
SAPLearningHub/
├── app/                          # Fiori Applications
│   ├── listreport/              # List Report & Object Page
│   │   ├── annotations.cds      # UI annotations
│   │   ├── webapp/
│   │   │   └── manifest.json    # App descriptor
│   │   ├── package.json
│   │   └── ui5.yaml
│   ├── treeview/                # Tree/Hierarchical View
│   │   ├── annotations.cds
│   │   ├── webapp/
│   │   │   └── manifest.json
│   │   ├── package.json
│   │   └── ui5.yaml
│   ├── analytics/               # Analytical List Page
│   │   ├── annotations.cds
│   │   ├── webapp/
│   │   │   └── manifest.json
│   │   ├── package.json
│   │   └── ui5.yaml
│   └── index.html               # Fiori Launchpad
├── app-router/                  # Application Router
│   ├── package.json
│   └── xs-app.json             # Routing configuration
├── db/                          # Database
│   ├── schema.cds              # Data model
│   └── data/                   # Sample CSV data
├── srv/                         # Services
│   └── service.cds             # OData service definitions
├── package.json                 # Root dependencies
├── mta.yaml                     # Multi-Target Application descriptor
├── xs-security.json            # Security configuration
├── .cdsrc.json                 # CDS configuration
└── README.md                    # This file
```

## 🔒 Security

### Authentication & Authorization

The application uses **SAP Authorization and Trust Management Service (XSUAA)** for security.

### Roles

1. **Admin** (`SAPLearningHub_Admin`)
   - Full access to all entities
   - Can create, edit, and delete courses
   - Manage categories and learning paths

2. **Instructor** (`SAPLearningHub_Instructor`)
   - Create and edit courses
   - View analytics
   - Read-only access to configuration

3. **Learner** (`SAPLearningHub_Learner`)
   - Browse courses and learning paths
   - View course details
   - Access analytics (read-only)

### Local Development

For local development, authentication is disabled by default. The approuter and XSUAA are only required for cloud deployment.

## 🛠 Development

### Adding New Data

1. Edit CSV files in `db/data/` folder
2. Follow the existing format (semicolon-separated)
3. Restart the server with `cds watch`

### Modifying Data Model

1. Edit `db/schema.cds`
2. Update service projections in `srv/service.cds`
3. Update UI annotations in `app/*/annotations.cds`
4. Run `cds watch` to redeploy

### Extending Applications

1. Modify annotations in respective `app/*/annotations.cds` files
2. Update manifest.json for routing or configuration changes
3. Use Fiori tools for guided development

## 📚 Additional Resources

- [SAP CAP Documentation](https://cap.cloud.sap/docs/)
- [SAP Fiori Elements](https://ui5.sap.com/test-resources/sap/fe/core/fpmExplorer/index.html)
- [SAP BTP Documentation](https://help.sap.com/docs/btp)
- [OData V4 Specification](https://www.odata.org/documentation/)

## 📄 License

ISC

## 👥 Author

RJTechRamjee

---

**Note**: This is a sample application designed for learning and demonstration purposes. For production use, additional security hardening, error handling, and performance optimization should be implemented.
