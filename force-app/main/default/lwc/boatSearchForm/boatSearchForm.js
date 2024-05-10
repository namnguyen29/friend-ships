import { LightningElement, wire } from "lwc";
import getBoatTypes from "@salesforce/apex/BoatDataService.getBoatTypes";

export default class BoatSearchForm extends LightningElement {
  selectedBoatTypeId = "";
  searchOptions = [];
  error = undefined;

  @wire(getBoatTypes)
  boatTypes({ error, data }) {
    if (data) {
      this.searchOptions = data.map((type) => ({
        label: type.Name,
        value: type.Id
      }));
      this.searchOptions = [{ label: "All Types", value: "" }, ...this.searchOptions];
    } else if (error) {
      this.searchOptions = undefined;
      this.error = error;
    }
  }

  handleSearchOptionChange(event) {
    this.selectedBoatTypeId = event.detail.value;
    const searchEvent = new CustomEvent("search", {
      detail: {
        boatTypeId: this.selectedBoatTypeId
      }
    });
    this.dispatchEvent(searchEvent);
  }
}