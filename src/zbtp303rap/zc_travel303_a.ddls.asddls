@EndUserText.label: 'Travel - Consumption'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel.semanticKey: ['TravelID']

define root view entity ZC_TRAVEL303_A
  provider contract transactional_query
  as projection on ZR_TRAVEL303_A
{
  key TravelUUID,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      TravelID,

      @Search.defaultSearchElement: true
      @ObjectModel.text.element: [ 'AgencyName' ]
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Agency_StdVH',
                                                     element: 'AgencyID'},
                                           useForValidation: true }]
      AgencyID,
      _Agency.Name              as AgencyName,

      @Search.defaultSearchElement: true
      @ObjectModel.text.element: [ 'CustomerName' ]
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Customer_StdVH',
                                                     element: 'CustomerID'},
                                           useForValidation: true 
                                           }]
      CustomerID,
      _Customer.LastName        as CustomerName,

      BeginDate,
      EndDate,

      BookingFee,
      TotalPrice,

      @Consumption.valueHelpDefinition: [{entity.name: 'I_CurrencyStdVH',
                                          entity.element: 'Currency',
                                          useForValidation: true }]
      CurrencyCode,

      Description,

      @ObjectModel.text.element: [ 'OverallStatusText' ]
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Overall_Status_VH',
                                                     element: 'OverallStatus'}}]
      OverallStatus,
      _OverallStatus._Text.Text as OverallStatusText : localized,

      LocalLastChangedAt,
      
      @Semantics.amount.currencyCode: 'CurrencyCode'
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_VIRTUAL_ELEM303'
      @EndUserText.label: 'Discount (10%)'  
      virtual Discount : /dmo/total_price,  
        
      /* Associations */
      _Agency,
      _Booking : redirected to composition child ZC_BOOKINGS303_A,
      _Currency,
      _Customer,
      _OverallStatus
}
