@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking - Root'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zr_bookings303_a
  as select from zbookings303_a

  association        to parent ZR_TRAVEL303_A    as _Travel        on  $projection.TravelUUID = _Travel.TravelUUID
  composition [0..*] of zr_booksuppl303_a        as _BookingSupplement


  association [1..1] to /DMO/I_Customer          as _Customer      on  $projection.CustomerID = _Customer.CustomerID
  association [1..1] to /DMO/I_Carrier           as _Carrier       on  $projection.AirlineID = _Carrier.AirlineID
  association [1..1] to /DMO/I_Connection        as _Connection    on  $projection.AirlineID    = _Connection.AirlineID
                                                                   and $projection.ConnectionID = _Connection.ConnectionID
  association [1..1] to /DMO/I_Booking_Status_VH as _BookingStatus on  $projection.BookingStatus = _BookingStatus.BookingStatus

{
  key booking_uuid         as BookingUUID,
      parent_uuid          as TravelUUID,

      booking_id           as BookingID,
      booking_date         as BookingDate,
      customer_id          as CustomerID,
      carrier_id           as AirlineID,
      connection_id        as ConnectionID,
      flight_date          as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight_price         as FlightPrice,
      currency_code        as CurrencyCode,
      booking_status       as BookingStatus,

      //local ETAG
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_change_at as LocalLastChangeAt,

      _Travel,
      _BookingSupplement,
      _Customer,
      _Carrier,
      _Connection,
      _BookingStatus
}
