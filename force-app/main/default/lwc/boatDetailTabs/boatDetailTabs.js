import { wire, LightningElement } from "lwc";
import { NavigationMixin } from "lightning/navigation";
import { subscribe, APPLICATION_SCOPE, MessageContext } from "lightning/messageService";
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import labelDetails from "@salesforce/label/c.Details";
import labelReviews from "@salesforce/label/c.Reviews";
import labelAddReview from "@salesforce/label/c.Add_Review";
import labelFullDetails from "@salesforce/label/c.Full_Details";
import labelPleaseSelectABoat from "@salesforce/label/c.Please_select_a_boat";
import BOAT_OBJECT from "@salesforce/schema/Boat__c";
import BOAT_ID_FIELD from "@salesforce/schema/Boat__c.Id";
import BOAT_NAME_FIELD from "@salesforce/schema/Boat__c.Name";
import BOAT_TYPE_FIELD from "@salesforce/schema/Boat__c.BoatType__c";
import BOAT_LENGTH_FIELD from "@salesforce/schema/Boat__c.Length__c";
import BOAT_DESCRIPTION_FIELD from "@salesforce/schema/Boat__c.Description__c";
import BOAT_PRICE_FIELD from "@salesforce/schema/Boat__c.Price__c";
import BOATMC from "@salesforce/messageChannel/BoatMessageChannel__c";

export const BOAT_FIELDS = [
  BOAT_ID_FIELD,
  BOAT_NAME_FIELD,
  BOAT_TYPE_FIELD,
  BOAT_LENGTH_FIELD,
  BOAT_DESCRIPTION_FIELD,
  BOAT_PRICE_FIELD
];

export default class BoatDetailTabs extends NavigationMixin(LightningElement) {
  @wire(MessageContext) messageContext;
  @wire(getRecord, { recordId: "$boatId", fields: BOAT_FIELDS }) wiredRecord;
  boatId = "";
  boatTypeField = BOAT_TYPE_FIELD;
  boatLengthField = BOAT_LENGTH_FIELD;
  boatDescriptionField = BOAT_DESCRIPTION_FIELD;
  boatPriceField = BOAT_PRICE_FIELD;
  objectApiName = BOAT_OBJECT;

  label = {
    labelDetails,
    labelReviews,
    labelAddReview,
    labelFullDetails,
    labelPleaseSelectABoat
  };
  subscription = null;

  connectedCallback() {
    this.subscribeMC();
  }

  get detailsTabIconName() {
    if (this.wiredRecord.data) {
      return "utility:anchor";
    }
    return null;
  }

  get boatName() {
    return getFieldValue(this.wiredRecord.data, BOAT_NAME_FIELD);
  }

  subscribeMC() {
    if (this.subscription) {
      return;
    }
    this.subscription = subscribe(
      this.messageContext,
      BOATMC,
      (message) => (this.boatId = message.recordId),
      { scope: APPLICATION_SCOPE }
    );
  }

  navigateToRecordViewPage() {
    this[NavigationMixin.Navigate]({
      type: "standard__recordPage",
      attributes: {
        objectApiName: "Boat__c",
        recordId: this.boatId,
        actionName: "view"
      }
    });
  }

  handleReviewCreated() {
    this.template.querySelector("lightning-tabset").activeTabValue = "reviews";
    console.log(JSON.stringify(this.template.querySelector("c-boat-reviews")));
    this.template.querySelector("c-boat-reviews").refresh();
  }
}