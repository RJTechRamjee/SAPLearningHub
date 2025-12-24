using {sap.learning.hub as db} from '../db/schema';

@path: '/catalog'
service CatalogService {

    // ========== Core Entities ==========

    @odata.draft.enabled
    entity Courses              as
        projection on db.Courses {
            *,
            categories.category.name as categoryName : String(100),
        }
        actions {
            action activate() returns Courses;
            action deactivate() returns Courses;
        };

    entity Categories           as projection on db.Categories;
    entity LearningPaths        as projection on db.LearningPaths;
    entity Topics               as projection on db.Topics;
    entity Instructors          as projection on db.Instructors;
    entity Modules              as projection on db.Modules;

    // ========== Association Entities ==========

    entity CourseCategories     as projection on db.CourseCategories;
    entity CourseTopics         as projection on db.CourseTopics;
    entity CourseInstructors    as projection on db.CourseInstructors;
    entity LearningPathCourses  as projection on db.LearningPathCourses;

    // ========== Analytics View ==========

    @readonly
    @Aggregation.ApplySupported.PropertyRestrictions: true
    entity CourseAnalytics      as
        projection on db.Courses {
            key ID,
                courseID,
                title,
                level,
                status,
                duration                                                   @Analytics.Measure @Aggregation.default: #SUM,
                price                                                      @Analytics.Measure @Aggregation.default: #SUM,
                currency,
                enrollmentCount                                            @Analytics.Measure @Aggregation.default: #SUM,
                rating                                                     @Analytics.Measure @Aggregation.default: #AVG,
                releaseDate,
                categories.category.name            as categoryName        @Analytics.Dimension,
                1                                   as courseCount : Integer @Analytics.Measure @Aggregation.default: #SUM,
                duration * enrollmentCount          as totalLearningHours : Integer @Analytics.Measure @Aggregation.default: #SUM,
        };

    // ========== Hierarchical View for Tree ==========

    @readonly
    entity LearningPathHierarchy as
        select from db.LearningPaths {
            key ID,
                pathID,
                name,
                description,
                level,
                estimatedDuration,
                status,
                courses.course.courseID    as courseID        : String(10),
                courses.course.title       as courseTitle     : String(200),
                courses.sequenceNumber     as courseSequence  : Integer,
                courses.isMandatory        as isMandatory     : Boolean,
        };
}

// ========== Annotations for Value Helps ==========

annotate CatalogService.Courses with {
    level    @Common.ValueList: {
        CollectionPath: 'Courses',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: level,
                ValueListProperty: 'level'
            },
        ]
    };

    status   @Common.ValueList: {
        CollectionPath: 'Courses',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: status,
                ValueListProperty: 'status'
            },
        ]
    };

    language @Common.ValueList: {
        CollectionPath: 'Courses',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: language,
                ValueListProperty: 'language'
            },
        ]
    };
}

annotate CatalogService.Categories with {
    parentCategory @Common.ValueList: {
        CollectionPath: 'Categories',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: parentCategory_ID,
                ValueListProperty: 'ID'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'name'
            },
        ]
    }                @Common.Text            : {
        $value                : parentCategory.name,
        ![@UI.TextArrangement]: #TextOnly
    };
}

annotate CatalogService.Topics with {
    category @Common.ValueList      : {
        CollectionPath: 'Categories',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: category_ID,
                ValueListProperty: 'ID'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'name'
            },
        ]
    }            @Common.Text            : {
        $value                : category.name,
        ![@UI.TextArrangement]: #TextOnly
    };
}

annotate CatalogService.Modules with {
    course      @Common.ValueList      : {
        CollectionPath: 'Courses',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: course_ID,
                ValueListProperty: 'ID'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'title'
            },
        ]
    }            @Common.Text            : {
        $value                : course.title,
        ![@UI.TextArrangement]: #TextOnly
    };

    contentType @Common.ValueList: {
        CollectionPath: 'Modules',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: contentType,
                ValueListProperty: 'contentType'
            },
        ]
    };
}
