Looking at the first one - Commbank API

```
curl -H "Accept: application/json" \
    -H "Content-Type: application/json" \
    -H "x-v: 2" \
    https://api.commbank.com.au/public/cds-au/v1/banking/products | npx json
```

This produces JSON data as below.

```json
{
  "data": {
    "products": [
      {
        "productId": "ad22b1f0967349e8a5d586afe7f0d845",
        "effectiveFrom": "2010-07-14T14:00:00Z",
        "effectiveTo": "9999-12-30T13:00:00Z",
        "lastUpdated": "2020-08-19T17:15:48.825612Z",
        "productCategory": "TRANS_AND_SAVINGS_ACCOUNTS",
        "name": "NetBank Saver",
        "description": "An online savings account with the flexibility to move money in and out of your linked CommBank transaction account using NetBank or the CommBank app.",
        "brand": "CBA",
        "brandName": "CommBank",
        "applicationUri": "https://www.commbank.com.au/banking/netbank-saver.html#apply",
        "isTailored": false,
        "additionalInformation": {
          "overviewUri": "https://www.commbank.com.au/banking/netbank-saver.html",
          "termsUri": "https://www.commbank.com.au/content/dam/commbank/personal/apply-online/download-printed-forms/SavingsInvestment_ADB2852.pdf",
          "eligibilityUri": "https://www.commbank.com.au/banking/netbank-saver.html#apply",
          "feesAndPricingUri": "https://www.commbank.com.au/banking/netbank-saver.html#rates"
        }
      },
      {
        "productId": "5b47845a7f0044e58db616bb734e8350",
        "effectiveFrom": "2014-12-31T13:00:00Z",
        "effectiveTo": "2099-12-30T13:00:00Z",
        "lastUpdated": "2020-06-04T06:00:07.251864Z",
        "productCategory": "CRED_AND_CHRG_CARDS",
        "name": "Interest-Free Days credit card",
        "description": "Designed for those looking for a card with a competitive interest-free period to help with business cash flow.",
        "brand": "CBA",
        "brandName": "CommBank",
        "applicationUri": "https://www.commbank.com.au/business/business-credit-cards/business-interest-free-days-credit-card.html",
        "isTailored": false,
        "additionalInformation": {
          "overviewUri": "https://www.commbank.com.au/business/business-credit-cards/business-interest-free-days-credit-card.html",
          "termsUri": "https://www.commbank.com.au/content/dam/commbank/personal/apply-online/download-printed-forms/cc2-cou.pdf",
          "eligibilityUri": "https://www.commbank.com.au/business/business-credit-cards/business-interest-free-days-credit-card.html",
          "feesAndPricingUri": "https://www.commbank.com.au/content/dam/commbank/business/pds/003-840-personal-liability-card-fees.pdf"
        }
      }
    ]
  },
  "links": {
    "self": "https://api.commbank.com.au/public/cds-au/v1/banking/products?page=1&page-size=25",
    "first": "https://api.commbank.com.au/public/cds-au/v1/banking/products?page=1&page-size=25",
    "next": "https://api.commbank.com.au/public/cds-au/v1/banking/products?page=2&page-size=25",
    "last": "https://api.commbank.com.au/public/cds-au/v1/banking/products?page=3&page-size=25"
  },
  "meta": {
    "totalRecords": 72,
    "totalPages": 3
  }
}
```
