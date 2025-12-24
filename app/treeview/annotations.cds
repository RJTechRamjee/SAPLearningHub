using CatalogService from '../../srv/service';

// ========== Tree View/Hierarchical Annotations ==========

annotate CatalogService.LearningPaths with @(
    UI.SelectionFields: [
        pathID,
        name,
        level,
        status,
    ],

    UI.LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: pathID,
            Label: 'Path ID'
        },
        {
            $Type: 'UI.DataField',
            Value: name,
            Label: 'Learning Path'
        },
        {
            $Type: 'UI.DataField',
            Value: level,
            Label: 'Level'
        },
        {
            $Type                 : 'UI.DataField',
            Value                 : estimatedDuration,
            Label                 : 'Est. Duration (hrs)',
            ![@HTML5.CssDefaults] : {width: '10rem'}
        },
        {
            $Type: 'UI.DataField',
            Value: status,
            Label: 'Status'
        },
    ],

    UI.PresentationVariant: {
        SortOrder     : [{
            Property  : pathID,
            Descending: false
        }],
        Visualizations: ['@UI.LineItem']
    },

    UI.HeaderInfo     : {
        TypeName      : 'Learning Path',
        TypeNamePlural: 'Learning Paths',
        Title         : {Value: name},
        Description   : {Value: pathID},
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
            Label : 'Courses in Path',
            Target: 'courses/@UI.LineItem'
        },
    ],

    UI.FieldGroup #GeneralInfo: {Data: [
        {Value: pathID},
        {Value: name},
        {Value: level},
        {Value: estimatedDuration},
        {Value: status},
        {Value: createdDate},
    ]},

    UI.FieldGroup #Description: {Data: [
        {Value: description},
        {Value: thumbnailURL},
    ]},
);

// LearningPathCourses LineItem with hierarchy
annotate CatalogService.LearningPathCourses with @(UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: sequenceNumber,
        Label: 'Sequence'
    },
    {
        $Type: 'UI.DataField',
        Value: course.courseID,
        Label: 'Course ID'
    },
    {
        $Type: 'UI.DataField',
        Value: course.title,
        Label: 'Course Title'
    },
    {
        $Type: 'UI.DataField',
        Value: course.duration,
        Label: 'Duration (hrs)'
    },
    {
        $Type: 'UI.DataField',
        Value: isMandatory,
        Label: 'Mandatory'
    },
    {
        $Type                 : 'UI.DataField',
        Value                 : estimatedCompletionDays,
        Label                 : 'Est. Days',
        ![@HTML5.CssDefaults] : {width: '8rem'}
    },
]);

// Hierarchical view annotations
annotate CatalogService.LearningPathHierarchy with @(
    UI.SelectionFields: [
        pathID,
        name,
        level,
        status
    ],

    UI.LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: pathID,
            Label: 'ID'
        },
        {
            $Type: 'UI.DataField',
            Value: name,
            Label: 'Learning Path / Course'
        },
        {
            $Type: 'UI.DataField',
            Value: level,
            Label: 'Level'
        },
        {
            $Type: 'UI.DataField',
            Value: estimatedDuration,
            Label: 'Duration (hrs)'
        },
        {
            $Type: 'UI.DataField',
            Value: courseSequence,
            Label: 'Sequence'
        },
        {
            $Type: 'UI.DataField',
            Value: status,
            Label: 'Status'
        },
    ],

    UI.PresentationVariant: {
        SortOrder     : [
            {
                Property  : pathID,
                Descending: false
            },
            {
                Property  : courseSequence,
                Descending: false
            }
        ],
        Visualizations: ['@UI.LineItem']
    }
);
