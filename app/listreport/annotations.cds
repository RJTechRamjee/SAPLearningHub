using CatalogService from '../../srv/service';

// ========== List Report Page Annotations ==========

annotate CatalogService.Courses with @(
    UI.SelectionFields: [
        courseID,
        title,
        level,
        status,
        language,
    ],

    UI.LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: courseID,
            Label: 'Course ID'
        },
        {
            $Type: 'UI.DataField',
            Value: title,
            Label: 'Title'
        },
        {
            $Type                  : 'UI.DataField',
            Value                  : categoryName,
            Label                  : 'Category',
            ![@HTML5.CssDefaults]  : {width: '10rem'}
        },
        {
            $Type                 : 'UI.DataField',
            Value                 : level,
            Label                 : 'Level',
            Criticality           : level,
            ![@HTML5.CssDefaults] : {width: '8rem'}
        },
        {
            $Type                 : 'UI.DataField',
            Value                 : duration,
            Label                 : 'Duration (hrs)',
            ![@HTML5.CssDefaults] : {width: '8rem'}
        },
        {
            $Type                 : 'UI.DataFieldForAnnotation',
            Label                 : 'Rating',
            Target                : '@UI.DataPoint#Rating',
            ![@HTML5.CssDefaults] : {width: '10rem'}
        },
        {
            $Type                 : 'UI.DataField',
            Value                 : enrollmentCount,
            Label                 : 'Enrollments',
            ![@HTML5.CssDefaults] : {width: '8rem'}
        },
        {
            $Type                 : 'UI.DataField',
            Value                 : price,
            Label                 : 'Price',
            ![@HTML5.CssDefaults] : {width: '8rem'}
        },
        {
            $Type                 : 'UI.DataField',
            Value                 : status,
            Label                 : 'Status',
            Criticality           : status,
            ![@HTML5.CssDefaults] : {width: '8rem'}
        },
    ],

    UI.HeaderInfo     : {
        TypeName      : 'Course',
        TypeNamePlural: 'Courses',
        Title         : {Value: title},
        Description   : {Value: courseID},
        ImageUrl      : thumbnailURL,
    },

    UI.Facets         : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneralInfo'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Description',
            Target: '@UI.FieldGroup#Description'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Pricing',
            Target: '@UI.FieldGroup#Pricing'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Statistics',
            Target: '@UI.FieldGroup#Statistics'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Categories',
            Target: 'categories/@UI.LineItem'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Topics',
            Target: 'topics/@UI.LineItem'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Instructors',
            Target: 'instructors/@UI.LineItem'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Modules',
            Target: 'modules/@UI.LineItem'
        },
    ],

    UI.FieldGroup #GeneralInfo: {Data: [
        {Value: courseID},
        {Value: title},
        {Value: level},
        {Value: language},
        {Value: version},
        {Value: status},
        {Value: releaseDate},
    ]},

    UI.FieldGroup #Description: {Data: [
        {Value: description},
        {Value: thumbnailURL},
    ]},

    UI.FieldGroup #Pricing    : {Data: [
        {Value: price},
        {Value: currency_code},
    ]},

    UI.FieldGroup #Statistics : {Data: [
        {Value: duration},
        {
            $Type: 'UI.DataFieldForAnnotation',
            Label: 'Rating',
            Target: '@UI.DataPoint#Rating'
        },
        {Value: enrollmentCount},
    ]},

    UI.DataPoint #Rating      : {
        Value        : rating,
        Visualization: #Rating,
        TargetValue  : 5,
    }
);

// CourseCategories LineItem
annotate CatalogService.CourseCategories with @(UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: category.name,
        Label: 'Category'
    },
    {
        $Type: 'UI.DataField',
        Value: category.description,
        Label: 'Description'
    },
]);

// CourseTopics LineItem
annotate CatalogService.CourseTopics with @(UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: topic.name,
        Label: 'Topic'
    },
    {
        $Type: 'UI.DataField',
        Value: topic.description,
        Label: 'Description'
    },
]);

// CourseInstructors LineItem
annotate CatalogService.CourseInstructors with @(UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: instructor.firstName,
        Label: 'First Name'
    },
    {
        $Type: 'UI.DataField',
        Value: instructor.lastName,
        Label: 'Last Name'
    },
    {
        $Type: 'UI.DataField',
        Value: instructor.email,
        Label: 'Email'
    },
]);

// Modules LineItem
annotate CatalogService.Modules with @(UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: sequenceNumber,
        Label: 'Sequence'
    },
    {
        $Type: 'UI.DataField',
        Value: title,
        Label: 'Module Title'
    },
    {
        $Type: 'UI.DataField',
        Value: contentType,
        Label: 'Type'
    },
    {
        $Type: 'UI.DataField',
        Value: duration,
        Label: 'Duration (min)'
    },
]);
