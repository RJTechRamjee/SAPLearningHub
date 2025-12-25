using { sap.learning.hub as db } from '../db/schema';

@path: '/catalog'
service CatalogService {
    
    // Main Courses entity from Excel
    entity Courses as projection on db.Courses;
    
}
