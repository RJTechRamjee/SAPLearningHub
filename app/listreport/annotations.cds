using CatalogService as service from '../../srv/service';

// ========== List Report Annotations ==========

annotate service.Courses with @(
    UI.SelectionFields: [
        learningObjectID,
        title,
        level,
        lscProductCategory,
        role
    ],
    UI.LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: learningObjectID,
            Label: 'Learning Object ID'
        },
        {
            $Type: 'UI.DataField',
            Value: title,
            Label: 'Title'
        },
        {
            $Type: 'UI.DataField',
            Value: level,
            Label: 'Level'
        },
        {
            $Type: 'UI.DataField',
            Value: role,
            Label: 'Role'
        },
        {
            $Type: 'UI.DataField',
            Value: durationInHours,
            Label: 'Duration (Hours)'
        },
        {
            $Type: 'UI.DataField',
            Value: lscProductCategory,
            Label: 'Product Category'
        },
        {
            $Type: 'UI.DataField',
            Value: learningType,
            Label: 'Type'
        }
    ],
    UI.HeaderInfo     : {
        TypeName      : 'Course',
        TypeNamePlural: 'Courses',
        Title         : {Value: title},
        Description   : {Value: learningObjectID}
    }
);

// ========== Object Page Annotations ==========

annotate service.Courses with @(
    UI.FieldGroup #GeneralInfo: {
        Label: 'General Information',
        Data : [
            {Value: learningObjectID},
            {Value: learningType},
            {Value: title},
            {Value: level},
            {Value: role},
            {Value: durationInHours},
            {Value: videoDuration}
        ]
    },
    UI.FieldGroup #ProductInfo: {
        Label: 'Product Information',
        Data : [
            {Value: lscProduct},
            {Value: lscProductCategory},
            {Value: lscProductSubcategory}
        ]
    },
    UI.FieldGroup #Details    : {
        Label: 'Details',
        Data : [
            {Value: description},
            {Value: learningObjectives},
            {Value: directLink},
            {Value: contentAvailableFrom}
        ]
    },
    UI.FieldGroup #Certification: {
        Label: 'Certification Information',
        Data : [
            {Value: relatedExams},
            {Value: relatedExamRetirementDate},
            {Value: alternateCertification},
            {Value: certificationRetirement}
        ]
    },
    UI.Facets             : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'General Information',
            Facets: [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'General',
                    Target: '@UI.FieldGroup#GeneralInfo'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Product',
                    Target: '@UI.FieldGroup#ProductInfo'
                }
            ]
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Description & Objectives',
            Target: '@UI.FieldGroup#Details'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Certification',
            Target: '@UI.FieldGroup#Certification'
        }
    ]
);
