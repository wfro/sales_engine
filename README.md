#SalesEngine 


We did the following extensions:

##CustomerRepository

* `most_items` returns the `Customer` who has purchased the most items by quantity
* `most_revenue` returns the `Customer` who has generated the most total revenue

##Customer

* `#pending_invoices` returns an array of `Invoice` instances for which there is no successful transaction

##InvoiceRepository

* `pending` returns an array of `Invoice` instances for which there is no successful transaction
