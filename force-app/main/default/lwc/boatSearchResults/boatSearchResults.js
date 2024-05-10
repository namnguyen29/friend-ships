import { LightningElement, api, track, wire } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { refreshApex } from "@salesforce/apex";
import { MessageContext, publish } from "lightning/messageService";
import { BOAT_COLUMNS } from "c/tableConst";
import BOATMC from "@salesforce/messageChannel/BoatMessageChannel__c";
import getBoats from "@salesforce/apex/BoatDataService.getBoats";
import updateBoatList from "@salesforce/apex/BoatDataService.updateBoatList";

const SUCCESS_VARIANT = "success";
const SUCCESS_TITLE = "Success";
const ERROR_VARIANT = "error";
const ERROR_TITLE = "Can't update Boats";
const MESSAGE_SHIP_IT = "Ship It!";

export default class BoatSearchResults extends LightningElement {
  @track boats;
  @api boatTypeId = "";
  @wire(MessageContext) messageContext;
  columns = BOAT_COLUMNS;
  selectedBoatId = "";
  isLoading = false;
  tableDraftValues = [];
  _wiredBoats;

  @api
  searchBoats() {
    // boatTypeId
    this.isLoading = true;
    this.notifyLoading(this.isLoading);
    //this.boatTypeId = boatTypeId;
  }

  @api
  async refresh() {
    this.isLoading = true;
    this.notifyLoading(this.isLoading);

    await refreshApex(this._wiredBoats);

    this.isLoading = false;
    this.notifyLoading(this.isLoading);
    this.tableDraftValues = [];
  }

  @wire(getBoats, { boatTypeId: "$boatTypeId" })
  wiredBoats(result) {
    this._wiredBoats = result;
    const { error, data } = result;
    if (data) {
      this.boats = data;
    } else if (error) {
      console.error(error);
    }
  }

  handleSave(event) {
    this.tableDraftValues = event.detail.draftValues;
    updateBoatList({ data: this.tableDraftValues })
      .then(() => {
        const toast = new ShowToastEvent({
          title: SUCCESS_TITLE,
          message: MESSAGE_SHIP_IT,
          variant: SUCCESS_VARIANT
        });
        this.dispatchEvent(toast);
        this.refresh();
      })
      .catch((error) => {
        const toast = new ShowToastEvent({
          title: ERROR_TITLE,
          message: error.message,
          variant: ERROR_VARIANT
        });
        this.dispatchEvent(toast);
      });
  }

  updateSelectedTile(event) {
    this.selectedBoatId = event.detail.boatId;
    this.sendMessageService(this.selectedBoatId);
  }

  sendMessageService(boatId) {
    publish(this.messageContext, BOATMC, { recordId: boatId });
  }

  notifyLoading(isLoading) {
    if (isLoading) {
      this.dispatchEvent(new CustomEvent("loading"));
    } else {
      this.dispatchEvent(CustomEvent("doneloading"));
    }
  }
}