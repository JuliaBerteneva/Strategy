CLASS zul_cl_concur_benefit_sender DEFINITION PUBLIC FINAL.
  PUBLIC SECTION.
    INTERFACES zul_if_benefit_data_sender.
ENDCLASS.

CLASS zul_cl_concur_benefit_sender IMPLEMENTATION.
  METHOD zul_if_benefit_data_sender~send_to_external_system.
    " Logic: Convert Data Model to Concur-specific XML
    " Trigger Web Service / REST API call to Concur
    WRITE: / 'Transforming benefit data to XML and transmitting to SAP Concur...'.
  ENDMETHOD.
ENDCLASS.
