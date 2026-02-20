CLASS zul_cl_hr_analytics_sender DEFINITION PUBLIC FINAL.
  PUBLIC SECTION.
    INTERFACES zul_if_benefit_data_sender.
ENDCLASS.

CLASS zul_cl_hr_analytics_sender IMPLEMENTATION.
  METHOD zul_if_benefit_data_sender~send_to_external_system.
    " Logic: Extract data from Model and format as CSV
    " Open dataset and write to Application Server path
    WRITE: / 'Formatting data to CSV for internal HR Analytics platform...'.
  ENDMETHOD.
ENDCLASS.
