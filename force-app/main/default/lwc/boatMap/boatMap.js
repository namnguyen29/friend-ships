import { api, LightningElement, wire } from "lwc";
import { getRecord } from "lightning/uiRecordApi";
import BOATMC from "@salesforce/messageChannel/BoatMessageChannel__c";
import {
  subscribe,
  unsubscribe,
  APPLICATION_SCOPE,
  MessageContext
} from "lightning/messageService";

const LONGITUDE_FIELD = "Boat__c.Geolocation__Longitude__s";
const LATITUDE_FIELD = "Boat__c.Geolocation__Latitude__s";
const BOAT_FIELDS = [LONGITUDE_FIELD, LATITUDE_FIELD];

export default class BoatMap extends LightningElement {
  @wire(MessageContext) MessageContext;
  error = undefined;
  mapMarkers = [];
  boatId;
  subscription = null;

  connectedCallback() {
    this.subscribeMC();
  }

  disconnectedCallback() {
    unsubscribe(this.subscription);
    this.subscription = null;
  }

  @api
  get recordId() {
    return this.boatId;
  }

  set recordId(value) {
    this.setAttribute("boatId", value);
    this.boatId = value;
  }

  @wire(getRecord, { recordId: "$boatId", fields: BOAT_FIELDS })
  wiredRecord({ error, data }) {
    if (data) {
      this.error = undefined;
      const longitude = data.fields.Geolocation__Longitude__s.value;
      const latitude = data.fields.Geolocation__Latitude__s.value;
      this.updateMap(longitude, latitude);
    } else if (error) {
      this.error = error;
      this.boatId = undefined;
      this.mapMarkers = [];
    }
  }

  subscribeMC() {
    if (this.subscription || this.recordId) {
      return;
    }
    this.subscription = subscribe(
      this.MessageContext,
      BOATMC,
      (message) => (this.boatId = message.recordId),
      { scope: APPLICATION_SCOPE }
    );
  }

  updateMap(Longitude, Latitude) {
    this.mapMarkers = [{ location: { Latitude, Longitude } }];
  }

  get showMap() {
    return this.mapMarkers.length > 0;
  }
}