namespace sap.learning.hub;

using {
    Currency,
    managed,
    cuid
} from '@sap/cds/common';

// ========== Core Entities ==========

entity Courses : cuid, managed {
    courseID        : String(10) @title: 'Course ID';
    title           : String(200) @title: 'Course Title' @mandatory;
    description     : String(2000) @title: 'Description';
    duration        : Integer @title: 'Duration (Hours)';
    level           : String(20) @title: 'Level' @assert.enum: [
        'Beginner',
        'Intermediate',
        'Advanced'
    ];
    language        : String(10) @title: 'Language' default 'EN';
    version         : String(10) @title: 'Version';
    status          : String(20) @title: 'Status' @assert.enum: [
        'Active',
        'Inactive',
        'Draft'
    ] default 'Draft';
    price           : Decimal(10, 2) @title: 'Price';
    currency        : Currency @title: 'Currency';
    releaseDate     : Date @title: 'Release Date';
    lastUpdated     : DateTime @title: 'Last Updated';
    thumbnailURL    : String(500) @title: 'Thumbnail URL';
    rating          : Decimal(3, 2) @title: 'Rating';
    enrollmentCount : Integer @title: 'Enrollment Count' default 0;

    // Associations
    categories      : Association to many CourseCategories
                          on categories.course = $self;
    topics          : Association to many CourseTopics
                          on topics.course = $self;
    instructors     : Association to many CourseInstructors
                          on instructors.course = $self;
    modules         : Composition of many Modules
                          on modules.course = $self;
    learningPaths   : Association to many LearningPathCourses
                          on learningPaths.course = $self;
}

entity Categories : cuid {
    categoryID     : String(10) @title: 'Category ID';
    name           : String(100) @title: 'Category Name' @mandatory;
    description    : String(500) @title: 'Description';
    parentCategory : Association to Categories @title: 'Parent Category';
    icon           : String(100) @title: 'Icon';
    sortOrder      : Integer @title: 'Sort Order';

    // Associations
    courses        : Association to many CourseCategories
                         on courses.category = $self;
    subCategories  : Association to many Categories
                         on subCategories.parentCategory = $self;
}

entity LearningPaths : cuid, managed {
    pathID            : String(10) @title: 'Learning Path ID';
    name              : String(200) @title: 'Path Name' @mandatory;
    description       : String(2000) @title: 'Description';
    level             : String(20) @title: 'Level' @assert.enum: [
        'Beginner',
        'Intermediate',
        'Advanced'
    ];
    estimatedDuration : Integer @title: 'Estimated Duration (Hours)';
    status            : String(20) @title: 'Status' @assert.enum: [
        'Active',
        'Inactive',
        'Draft'
    ] default 'Draft';
    createdDate       : Date @title: 'Created Date';
    thumbnailURL      : String(500) @title: 'Thumbnail URL';

    // Associations
    courses           : Association to many LearningPathCourses
                            on courses.learningPath = $self;
}

entity Topics : cuid {
    topicID     : String(10) @title: 'Topic ID';
    name        : String(100) @title: 'Topic Name' @mandatory;
    description : String(500) @title: 'Description';
    category    : Association to Categories @title: 'Category';

    // Associations
    courses     : Association to many CourseTopics
                      on courses.topic = $self;
}

entity Instructors : cuid {
    instructorID : String(10) @title: 'Instructor ID';
    firstName    : String(50) @title: 'First Name' @mandatory;
    lastName     : String(50) @title: 'Last Name' @mandatory;
    email        : String(100) @title: 'Email';
    bio          : String(1000) @title: 'Biography';
    expertise    : String(500) @title: 'Expertise';
    rating       : Decimal(3, 2) @title: 'Rating';
    photoURL     : String(500) @title: 'Photo URL';

    // Associations
    courses      : Association to many CourseInstructors
                       on courses.instructor = $self;
}

entity Modules : cuid {
    moduleID       : String(10) @title: 'Module ID';
    course         : Association to Courses @title: 'Course';
    title          : String(200) @title: 'Module Title' @mandatory;
    description    : String(1000) @title: 'Description';
    duration       : Integer @title: 'Duration (Minutes)';
    sequenceNumber : Integer @title: 'Sequence Number';
    contentType    : String(20) @title: 'Content Type' @assert.enum: [
        'Video',
        'Document',
        'Interactive',
        'Quiz'
    ];
}

// ========== Association/Join Entities ==========

entity CourseCategories : cuid {
    course   : Association to Courses @title: 'Course';
    category : Association to Categories @title: 'Category';
}

entity CourseTopics : cuid {
    course : Association to Courses @title: 'Course';
    topic  : Association to Topics @title: 'Topic';
}

entity CourseInstructors : cuid {
    course     : Association to Courses @title: 'Course';
    instructor : Association to Instructors @title: 'Instructor';
}

entity LearningPathCourses : cuid {
    learningPath             : Association to LearningPaths @title: 'Learning Path';
    course                   : Association to Courses @title: 'Course';
    sequenceNumber           : Integer @title: 'Sequence Number';
    isMandatory              : Boolean @title: 'Is Mandatory' default true;
    estimatedCompletionDays  : Integer @title: 'Estimated Completion (Days)';
}

// ========== Views for Analytics ==========

@readonly
entity CourseAnalytics as
    select from Courses {
        key ID,
            courseID,
            title,
            level,
            status,
            duration,
            price,
            currency,
            enrollmentCount,
            rating,
            releaseDate,
            categories.category.name as categoryName : String(100),
    };
