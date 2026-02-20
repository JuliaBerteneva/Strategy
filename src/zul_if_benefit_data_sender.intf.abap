INTERFACE zul_if_benefit_data_sender
  PUBLIC .
  METHODS: send_to_external_system IMPORTING it_data TYPE ANY TABLE.
ENDINTERFACE.
