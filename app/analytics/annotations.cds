using CatalogService from '../../srv/service';

// ========== Analytical List Page Annotations ==========

annotate CatalogService.CourseAnalytics with @(
    UI.SelectionFields            : [
        level,
        status,
        categoryName,
    ],

    UI.LineItem                   : [
        {
            $Type: 'UI.DataField',
            Value: courseID,
            Label: 'Course ID'
        },
        {
            $Type: 'UI.DataField',
            Value: title,
            Label: 'Course Title'
        },
        {
            $Type: 'UI.DataField',
            Value: categoryName,
            Label: 'Category'
        },
        {
            $Type: 'UI.DataField',
            Value: level,
            Label: 'Level'
        },
        {
            $Type: 'UI.DataField',
            Value: duration,
            Label: 'Duration (hrs)'
        },
        {
            $Type: 'UI.DataField',
            Value: enrollmentCount,
            Label: 'Enrollments'
        },
        {
            $Type: 'UI.DataField',
            Value: rating,
            Label: 'Rating'
        },
        {
            $Type: 'UI.DataField',
            Value: price,
            Label: 'Price'
        },
    ],

    // KPI Definitions
    UI.KPI #TotalCourses          : {
        Detail                  : {
            DefaultPresentationVariant: ![@UI.PresentationVariant],
            SemanticObject            : 'Course',
            Action                    : 'analyze'
        },
        SelectionVariant        : {
            SelectOptions: []
        },
        DataPoint               : {
            Value        : courseCount,
            Title        : 'Total Courses',
            Visualization: #Number
        },
        ID                      : 'TotalCourses',
        ShortDescription        : 'Total number of courses'
    },

    UI.KPI #TotalEnrollments      : {
        Detail                  : {
            DefaultPresentationVariant: ![@UI.PresentationVariant],
            SemanticObject            : 'Course',
            Action                    : 'analyze'
        },
        SelectionVariant        : {
            SelectOptions: []
        },
        DataPoint               : {
            Value        : enrollmentCount,
            Title        : 'Total Enrollments',
            Visualization: #Number
        },
        ID                      : 'TotalEnrollments',
        ShortDescription        : 'Total course enrollments'
    },

    UI.KPI #AverageRating         : {
        Detail                  : {
            DefaultPresentationVariant: ![@UI.PresentationVariant],
            SemanticObject            : 'Course',
            Action                    : 'analyze'
        },
        SelectionVariant        : {
            SelectOptions: []
        },
        DataPoint               : {
            Value        : rating,
            Title        : 'Average Rating',
            TargetValue  : 5,
            Visualization: #Number
        },
        ID                      : 'AverageRating',
        ShortDescription        : 'Average course rating'
    },

    UI.KPI #TotalLearningHours    : {
        Detail                  : {
            DefaultPresentationVariant: ![@UI.PresentationVariant],
            SemanticObject            : 'Course',
            Action                    : 'analyze'
        },
        SelectionVariant        : {
            SelectOptions: []
        },
        DataPoint               : {
            Value        : totalLearningHours,
            Title        : 'Total Learning Hours',
            Visualization: #Number
        },
        ID                      : 'TotalLearningHours',
        ShortDescription        : 'Total learning hours available'
    },

    // Chart Definitions
    UI.Chart #CoursesByCategory   : {
        ChartType        : #Bar,
        Title            : 'Courses by Category',
        Description      : 'Number of courses per category',
        Dimensions       : [categoryName],
        Measures         : [courseCount],
        MeasureAttributes: [{
            DataPoint: '@UI.DataPoint#CourseCount',
            Role     : #Axis1,
            Measure  : courseCount
        }]
    },

    UI.Chart #CoursesByLevel      : {
        ChartType        : #Donut,
        Title            : 'Courses by Level',
        Description      : 'Course distribution by difficulty level',
        Dimensions       : [level],
        Measures         : [courseCount],
        MeasureAttributes: [{
            DataPoint: '@UI.DataPoint#CourseCount',
            Role     : #Axis1,
            Measure  : courseCount
        }]
    },

    UI.Chart #EnrollmentsByCategory: {
        ChartType        : #Column,
        Title            : 'Enrollments by Category',
        Description      : 'Total enrollments per category',
        Dimensions       : [categoryName],
        Measures         : [enrollmentCount],
        MeasureAttributes: [{
            DataPoint: '@UI.DataPoint#Enrollments',
            Role     : #Axis1,
            Measure  : enrollmentCount
        }]
    },

    UI.Chart #CourseReleases      : {
        ChartType        : #Line,
        Title            : 'Course Releases Over Time',
        Description      : 'Timeline of course releases',
        Dimensions       : [releaseDate],
        Measures         : [courseCount],
        MeasureAttributes: [{
            DataPoint: '@UI.DataPoint#CourseCount',
            Role     : #Axis1,
            Measure  : courseCount
        }]
    },

    // DataPoint Definitions
    UI.DataPoint #CourseCount     : {
        Value        : courseCount,
        Title        : 'Course Count',
        Visualization: #Number
    },

    UI.DataPoint #Enrollments     : {
        Value        : enrollmentCount,
        Title        : 'Enrollments',
        Visualization: #Number
    },

    // Presentation Variant
    UI.PresentationVariant        : {
        SortOrder     : [{
            Property  : courseID,
            Descending: false
        }],
        Visualizations: [
            '@UI.LineItem',
            '@UI.Chart#CoursesByCategory',
            '@UI.Chart#CoursesByLevel',
            '@UI.Chart#EnrollmentsByCategory',
            '@UI.Chart#CourseReleases'
        ],
        MaxItems      : 10
    },

    // Selection Presentation Variant
    UI.SelectionPresentationVariant #Default: {
        Text                : 'Default',
        SelectionVariant    : {
            SelectOptions: [],
            Text         : 'All Courses'
        },
        PresentationVariant : ![@UI.PresentationVariant]
    },

    UI.SelectionPresentationVariant #ActiveCourses: {
        Text                : 'Active Courses',
        SelectionVariant    : {
            SelectOptions: [{
                PropertyName: status,
                Ranges      : [{
                    Sign  : #I,
                    Option: #EQ,
                    Low   : 'Active'
                }]
            }],
            Text         : 'Active Courses Only'
        },
        PresentationVariant : ![@UI.PresentationVariant]
    },

    UI.SelectionPresentationVariant #BeginnerCourses: {
        Text                : 'Beginner Courses',
        SelectionVariant    : {
            SelectOptions: [{
                PropertyName: level,
                Ranges      : [{
                    Sign  : #I,
                    Option: #EQ,
                    Low   : 'Beginner'
                }]
            }],
            Text         : 'Beginner Level Courses'
        },
        PresentationVariant : ![@UI.PresentationVariant]
    }
);

// Analytics Annotations
annotate CatalogService.CourseAnalytics with {
    courseCount       @(
        title                : 'Course Count',
        Analytics.Measure    : true,
        Aggregation.default  : #SUM,
        Common.Label         : 'Number of Courses'
    );

    duration          @(
        title                : 'Duration',
        Analytics.Measure    : true,
        Aggregation.default  : #SUM,
        Common.Label         : 'Total Duration (Hours)'
    );

    enrollmentCount   @(
        title                : 'Enrollments',
        Analytics.Measure    : true,
        Aggregation.default  : #SUM,
        Common.Label         : 'Total Enrollments'
    );

    rating            @(
        title                : 'Rating',
        Analytics.Measure    : true,
        Aggregation.default  : #AVG,
        Common.Label         : 'Average Rating'
    );

    price             @(
        title                : 'Price',
        Analytics.Measure    : true,
        Aggregation.default  : #SUM,
        Common.Label         : 'Total Revenue'
    );

    totalLearningHours@(
        title                : 'Learning Hours',
        Analytics.Measure    : true,
        Aggregation.default  : #SUM,
        Common.Label         : 'Total Learning Hours'
    );

    level             @(
        Analytics.Dimension  : true,
        Common.Label         : 'Course Level'
    );

    status            @(
        Analytics.Dimension  : true,
        Common.Label         : 'Course Status'
    );

    categoryName      @(
        Analytics.Dimension  : true,
        Common.Label         : 'Category'
    );
}
