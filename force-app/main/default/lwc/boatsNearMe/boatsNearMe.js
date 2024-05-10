import { LightningElement, wire, api } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import getBoatsByLocation from "@salesforce/apex/BoatDataService.getBoatsByLocation";

const LABEL_YOU_ARE_HERE = "You are here!";
const ICON_STANDARD_USER = "standard:user";
const ERROR_TITLE = "Error loading Boats Near Me";
const ERROR_VARIANT = "error";

export default class BoatsNearMe extends LightningElement {
  @api boatTypeId;
  latitude = 0;
  longitude = 0;
  isLoading = true;
  isRendered = false;
  mapMarkers = [];

  renderedCallback() {
    if (!this.isRendered) {
      this.getLocationFromBrowser();
    }
    this.isRendered = true;
  }

  @wire(getBoatsByLocation, {
    latitude: "$latitude",
    longitude: "$longitude",
    boatTypeId: "$boatTypeId"
  })
  wiredBoatsJSON({ error, data }) {
    if (error) {
      const toast = new ShowToastEvent({
        title: ERROR_TITLE,
        message: error.message,
        variant: ERROR_VARIANT
      });
      this.dispatchEvent(toast);
    } else if (data) {
      this.createMapMarkers(data);
    }
    this.isLoading = false;
  }

  getLocationFromBrowser() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition((position) => {
        this.latitude = position.coords.latitude;
        this.longitude = position.coords.longitude;
      });
    }
  }

  createMapMarkers(boatData) {
    let newMarkers = JSON.parse(boatData).map((boat) => ({
      title: boat.Name,
      location: {
        Latitude: boat.Geolocation__Latitude__s,
        Longitude: boat.Geolocation__Longitude__s
      }
    }));
    newMarkers = [
      {
        title: LABEL_YOU_ARE_HERE,
        icon: ICON_STANDARD_USER,
        location: {
          Latitude: this.latitude,
          Longitude: this.longitude
        }
      },
      ...newMarkers
    ];
    this.mapMarkers = newMarkers;
  }
}