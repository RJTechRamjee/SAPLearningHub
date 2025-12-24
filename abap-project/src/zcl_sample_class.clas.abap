CLASS zcl_sample_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      "! Constructor
      constructor,
      
      "! Get greeting message
      "! @parameter iv_name | Name to greet
      "! @parameter rv_greeting | Greeting message
      get_greeting
        IMPORTING iv_name TYPE string
        RETURNING VALUE(rv_greeting) TYPE string.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: mv_default_greeting TYPE string.

ENDCLASS.

CLASS zcl_sample_class IMPLEMENTATION.

  METHOD constructor.
    mv_default_greeting = 'Hello from SAP Learning Hub'.
  ENDMETHOD.

  METHOD get_greeting.
    IF iv_name IS NOT INITIAL.
      rv_greeting = |{ mv_default_greeting }, { iv_name }!|.
    ELSE.
      rv_greeting = |{ mv_default_greeting }!|.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
