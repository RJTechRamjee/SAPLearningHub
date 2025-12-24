const cds = require('@sap/cds');

module.exports = cds.service.impl(async function() {
  const { Books, Courses } = this.entities;

  // Sample event handler for Books
  this.before('CREATE', 'Books', async (req) => {
    // Validate stock is non-negative
    if (req.data.stock < 0) {
      req.error(400, 'Stock cannot be negative');
    }
    console.log('Creating a new book:', req.data.title);
  });

  // Sample event handler for Courses
  this.before('CREATE', 'Courses', async (req) => {
    // Validate duration is positive
    if (req.data.duration <= 0) {
      req.error(400, 'Course duration must be positive');
    }
    console.log('Creating a new course:', req.data.title);
  });

  // After-read handler to add discount information
  this.after('READ', 'Books', (books) => {
    // Handle both single book and array of books
    const bookArray = Array.isArray(books) ? books : [books];
    
    bookArray.forEach(book => {
      if (book) {
        // Add virtual discount field for books priced over 50
        book.hasDiscount = book.price > 50;
      }
    });
    
    return books;
  });
});
