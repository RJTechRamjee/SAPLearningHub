# Data Model Simplification - Changes Summary

## Issue Addressed
The user reported that the data model had many unwanted fields and requested simplification based on the Excel file provided (`SAP Learning site catalog sample.xlsx`).

## Changes Made

### 1. Simplified Data Model (`db/schema.cds`)

**Before:** Complex model with 6 core entities + 4 association entities
- Courses (with many custom fields)
- Categories
- LearningPaths  
- Topics
- Instructors
- Modules
- Plus 4 M:N association tables

**After:** Single entity matching Excel columns exactly
```cds
entity Courses : managed {
    key ID: UUID;
    learningObjectID    : String(20)
    learningType        : String(50)
    title               : String(500)
    description         : String(5000)
    learningObjectivesSteam : String(5000)
    learningObjectives  : String(5000)
    durationInHours     : Integer
    videoDuration       : String(50)
    directLink          : String(1000)
    contentAvailableFrom: Date
    level               : String(20)
    role                : String(100)
    lscProduct          : String(200)
    lscProductCategory  : String(200)
    lscProductSubcategory: String(200)
    relatedExams        : String(500)
    relatedExamRetirementDate : Date
    alternateCertification  : String(500)
    certificationRetirement : Date
}
```

### 2. Simplified Service (`srv/service.cds`)

**Before:** 14 entity sets with analytics views
**After:** Single entity projection
```cds
service CatalogService {
    entity Courses as projection on db.Courses;
}
```

### 3. Updated Sample Data

**Before:** Multiple CSV files with synthetic data
**After:** Single CSV file with real data from Excel
- Converted Excel data to CSV format
- **23 courses** loaded from `SAP Learning site catalog sample.xlsx`
- All 19 columns from Excel mapped to schema fields

### 4. Simplified Fiori Application

**Before:** 3 complex Fiori apps (List Report, Tree View, Analytics)
**After:** 1 focused List Report app
- Removed analytics and treeview apps (not needed for simplified model)
- Updated annotations to match new schema fields
- Created standalone index.html for the app

### 5. New Homepage

Created a simplified landing page (`app/index.html`) that:
- Shows total course count (23 courses)
- Displays statistics by level
- Provides direct links to:
  - Course Catalog Fiori app
  - OData service endpoints
  - Metadata viewer

## Files Changed

### Modified
- `db/schema.cds` - Simplified to single Courses entity
- `srv/service.cds` - Simplified to single entity projection
- `db/data/sap.learning.hub-Courses.csv` - Converted from Excel
- `app/listreport/annotations.cds` - Updated for new fields
- `app/index.html` - New simplified homepage

### Deleted
- All association entity CSV files
- `app/treeview/annotations.cds`
- `app/analytics/annotations.cds`
- Old sample data files (Categories, Topics, Instructors, etc.)

### Added
- `app/listreport/webapp/index.html` - Standalone app launcher
- `app/index-launchpad.html` - Backup of old launchpad config

## Testing Results

✅ **OData Service Working**
- Endpoint: `http://localhost:4004/catalog/Courses`
- Total records: 23 courses
- All fields accessible via OData V4

✅ **Data Loaded Successfully**
- All 23 rows from Excel imported
- Statistics available:
  - ADVANCED: 14 courses
  - BEGINNER: 5 courses
  - NONE: 2 courses
  - Not specified: 2 courses

✅ **Homepage Functional**
- Shows real-time course count
- Displays level-based statistics
- Links to catalog app and OData endpoints

## Breaking Changes

⚠️ **Removed Features:**
- Learning Paths functionality
- Categories and Topics
- Instructors
- Modules
- Analytics views
- Tree/hierarchy views

These were removed as they were not present in the Excel data source.

## Migration Notes

The new data model is much simpler and directly reflects the Excel structure. If you need to:
- Add more courses: Update the Excel file and re-run the conversion script
- Extend the model: Add new fields to `db/schema.cds` and update `srv/service.cds`
- Add back features: They can be re-introduced based on additional data sources

## Next Steps

1. For deployment to BTP, build and deploy:
   ```bash
   mbt build
   cf deploy mta_archives/sap-learning-hub_1.0.0.mtar
   ```

2. To update data:
   - Edit Excel file
   - Re-run Python conversion script
   - Redeploy database
