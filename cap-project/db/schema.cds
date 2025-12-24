namespace sap.learning;

/**
 * Sample Entity for Learning CAP
 */
entity Books {
  key ID : UUID;
  title  : String(100);
  author : String(100);
  stock  : Integer;
  price  : Decimal(10,2);
}

/**
 * Sample Entity for Course Management
 */
entity Courses {
  key ID : UUID;
  title       : String(200);
  description : String(1000);
  instructor  : String(100);
  duration    : Integer; // in hours
  price       : Decimal(10,2);
}
