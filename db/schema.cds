namespace sap.learning.hub;

using { managed } from '@sap/cds/common';

// ========== Core Entity based on Excel columns ==========

entity Courses : managed {
    key ID                  : UUID;
    learningObjectID        : String(20) @title: 'Learning Object ID' @mandatory;
    learningType            : String(50) @title: 'Learning Type';
    title                   : String(500) @title: 'Title' @mandatory;
    description             : String(5000) @title: 'Description';
    learningObjectivesSteam : String(5000) @title: 'Learning Objectives Steam';
    learningObjectives      : String(5000) @title: 'Learning Objectives';
    durationInHours         : Integer @title: 'Duration (Hours)';
    videoDuration           : String(50) @title: 'Video Duration';
    directLink              : String(1000) @title: 'Direct Link';
    contentAvailableFrom    : Date @title: 'Content Available From';
    level                   : String(20) @title: 'Level';
    role                    : String(100) @title: 'Role';
    lscProduct              : String(200) @title: 'LSC Product';
    lscProductCategory      : String(200) @title: 'LSC Product Category';
    lscProductSubcategory   : String(200) @title: 'LSC Product Subcategory';
    relatedExams            : String(500) @title: 'Related Exams';
    relatedExamRetirementDate : Date @title: 'Related Exam Retirement Date';
    alternateCertification  : String(500) @title: 'Alternate Certification';
    certificationRetirement : Date @title: 'Certification Retirement';
}
