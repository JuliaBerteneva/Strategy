# Strategy Pattern in ABAP — Benefit Data Sender Example

This repository contains a minimal ABAP example of the **Strategy** behavioral pattern.

The goal is to keep the main integration flow stable while allowing the **sending algorithm** to change depending on the target system (format, protocol, destination, etc.). Instead of building large `CASE` / `IF` blocks inside the integration class, each variant is implemented as a separate strategy class behind a common interface.

## The Idea

We want to send the same benefit data to different systems, but each system expects a different representation:

- **SAP Concur** expects **XML** (example sender: `zcl_concur_benefit_sender`)
- **HR Analytics** expects **CSV** (example sender: `zcl_hr_analytics_sender`)

The integration handler (`zcl_benefit_integration_handler`) does not know the details. It only works with the interface and delegates the work to the injected strategy.

## Structure

`zif_benefit_data_sender`  
A stable contract for all senders. The handler depends only on this interface.

`zcl_concur_benefit_sender`  
Concrete strategy: transforms benefit data to Concur-specific XML and transmits it (placeholder `WRITE` in the demo).

`zcl_hr_analytics_sender`  
Concrete strategy: formats data as CSV for an internal platform (placeholder `WRITE` in the demo).

`zcl_benefit_integration_handler`  
Context class: stores a reference to the interface (`mo_sender_strategy`) and delegates sending to the selected strategy.

## Why Strategy is Useful in ABAP

This approach is especially relevant in ABAP systems because business logic changes frequently and integrations grow over time.

What you get:

- **Open–Closed Design**: add a new target system by adding a new class, without modifying the handler
- **Less conditional logic**: replaces large `CASE` statements with polymorphism
- **Better testability**: each strategy can be tested in isolation
- **Clear separation of responsibilities**: the handler orchestrates, strategies implement the “how”

## How It Works

At runtime you decide which target system you need, select the strategy, inject it into the handler, and run the integration:

```abap
DATA(lo_handler) = NEW zcl_benefit_integration_handler( ).
DATA(lv_target_system) = 'CONCUR'. " Determined at runtime

CASE lv_target_system.
  WHEN 'CONCUR'.
    lo_handler->set_sender_strategy( NEW zcl_concur_benefit_sender( ) ).
  WHEN 'HR_ANALYTICS'.
    lo_handler->set_sender_strategy( NEW zcl_hr_analytics_sender( ) ).
ENDCASE.

lo_handler->run_integration( lt_emp_benefits ).
```

The handler does not care whether the active strategy produces XML, CSV, or any other format. It simply calls the interface method.

Extending the Example
To add another system (e.g., WORKDAY or S/4 Middleware):
Create a new class implementing zif_benefit_data_sender
Implement send_to_external_system
Select and inject the new class in the runtime selection logic (or move selection to customizing / factory)

## Related Blog Post

You can read the full explanation of Strategy vs Template Method in ABAP in my blog post:
https://julialopina.com/template_strategy
