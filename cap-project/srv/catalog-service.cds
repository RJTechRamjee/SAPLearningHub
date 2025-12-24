using { sap.learning as db } from '../db/schema';

/**
 * Service for managing Books
 */
service CatalogService {
  entity Books as projection on db.Books;
  entity Courses as projection on db.Courses;
}
