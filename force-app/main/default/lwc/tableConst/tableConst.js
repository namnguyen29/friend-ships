import BOAT_NAME_FIELD from "@salesforce/schema/Boat__c.Name";
import BOAT_LENGTH_FIELD from "@salesforce/schema/Boat__c.Length__c";
import BOAT_PRICE_FIELD from "@salesforce/schema/Boat__c.Price__c";
import BOAT_DESC_FIELD from "@salesforce/schema/Boat__c.Description__c";

export const BOAT_COLUMNS = [
  { label: "Name", fieldName: BOAT_NAME_FIELD.fieldApiName, type: "text", editable: true },
  { label: "Length", fieldName: BOAT_LENGTH_FIELD.fieldApiName, type: "number" },
  {
    label: "Price",
    fieldName: BOAT_PRICE_FIELD.fieldApiName,
    type: "currency",
    typeAttributes: { currencyCode: "USD", step: "0.001" }
  },
  { label: "Description", fieldName: BOAT_DESC_FIELD.fieldApiName, type: "text" }
];