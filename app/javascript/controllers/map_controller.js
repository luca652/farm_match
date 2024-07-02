import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'
// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String
  }

  static targets = ["longitude", "latitude"]

  connect() {

    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: 'map',
      style: "mapbox://styles/mapbox/streets-v10",
      center: [-8.2439, 53.4129],
      zoom: 5
    })

    this.addMarker()
  }

  addMarker() {

    this.map.on('load', () => {
      const marker = new mapboxgl.Marker({
        draggable: true
      })
      .setLngLat([-8.2439, 53.4129])
      .addTo(this.map);

      // Update coordinates when marker is dragged
      marker.on('dragend', () => {
        const lngLat = marker.getLngLat();
        // Update some target with new coordinates if needed
        this.setCoordinates([lngLat.lng, lngLat.lat]);
      });
    });
  }

  setCoordinates(coordinates) {
    this.longitudeTarget.value = coordinates[0].toFixed(6);
    this.latitudeTarget.value = coordinates[1].toFixed(6);
  }
}
