/**
 * Global registries for map objects
 */
window.placemarks = window.placemarks || {};
window.polygons = window.polygons || {};
window.polylines = window.polylines || {};

/**
 * Represents a geocoding result with coordinates and address information
 */
class JsGeocodeResult {
  /**
   * @param {number} lat - Latitude coordinate
   * @param {number} lon - Longitude coordinate
   * @param {string} name - Formal address name
   * @param {string} description - Additional address details
   */
  constructor(lat, lon, name, description) {
    this.lat = lat;
    this.lon = lon;
    this.name = name;
    this.description = description;
  }
}

/**
 * Represents a suggest (autocomplete) result
 */
class JsSuggestResult {
  /**
   * Creates a suggestion result object
   * @param {string} displayName - Formatted display name
   * @param {string} value - Raw value for selection
   */
  constructor(displayName, value) {
    this.displayName = displayName;
    this.value = value;
  }
}

// Expose classes to global scope for interop with Dart
window.JsGeocodeResult = JsGeocodeResult;
window.JsSuggestResult = JsSuggestResult;

/**
 * Main controller class for Yandex Maps operations
 * Provides async API for map manipulation
 */
window.yandexMapController = {
  /**
   * Moves map center to specified coordinates
   * @param {number} lat - Target latitude
   * @param {number} lon - Target longitude
   * @param {number} zoom - Zoom level
   * @param {number} duration - Animation duration in milliseconds
   * @param {string} mapId - ID of target map instance
   * @returns {Promise<void>}
   */
  moveTo: async function (lat, lon, zoom, duration, mapId) {
    return new Promise((resolve, reject) => {
      try {
        const map = window.yandexMaps[mapId];
        if (!map) return reject("Map not initialized.");
        map.setCenter([lat, lon], zoom, { duration: duration || 300 });
        resolve();
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Sets map zoom level
   * @param {number} zoom - Target zoom level
   * @param {number} duration - Animation duration in milliseconds
   * @param {string} mapId - ID of target map instance
   * @returns {Promise<void>}
   */
  setZoom: async function (zoom, duration, mapId) {
    return new Promise((resolve, reject) => {
      try {
        const map = window.yandexMaps[mapId];
        if (!map) return reject("Map not initialized.");
        map.setZoom(zoom, { duration: duration || 300 });
        resolve();
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Zooms in by one level
   * @param {number} duration - Animation duration in milliseconds
   * @param {string} mapId - ID of target map instance
   * @returns {Promise<void>}
   */
  zoomIn: async function (duration, mapId) {
    return new Promise((resolve, reject) => {
      try {
        const map = window.yandexMaps[mapId];
        if (!map) return reject("Map not initialized.");
        map.setZoom(map.getZoom() + 1, { duration: duration || 300 });
        resolve();
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Zooms out by one level
   * @param {number} duration - Animation duration in milliseconds
   * @param {string} mapId - ID of target map instance
   * @returns {Promise<void>}
   */
  zoomOut: async function (duration, mapId) {
    return new Promise((resolve, reject) => {
      try {
        const map = window.yandexMaps[mapId];
        if (!map) return reject("Map not initialized.");
        map.setZoom(map.getZoom() - 1, { duration: duration || 300 });
        resolve();
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Gets current zoom level
   * @param {string} mapId - ID of target map instance
   * @returns {Promise<number>} Current zoom level
   */
  getZoom: async function (mapId) {
    return new Promise((resolve, reject) => {
      try {
        const map = window.yandexMaps[mapId];
        if (!map) return reject("Map not initialized.");
        resolve(map.getZoom());
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Gets current map center coordinates
   * @param {string} mapId - ID of target map instance
   * @returns {Promise<Array<number>>} [longitude, latitude] coordinates
   */
  getCenter: async function (mapId) {
    return new Promise((resolve, reject) => {
      try {
        const map = window.yandexMaps[mapId];
        if (!map) return reject("Map not initialized.");
        resolve(map.getCenter());
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Adjusts view to contain specified bounds
   * @param {number} swLat - South-west latitude
   * @param {number} swLon - South-west longitude
   * @param {number} neLat - North-east latitude
   * @param {number} neLon - North-east longitude
   * @param {number} duration - Animation duration in milliseconds
   * @param {string} mapId - ID of target map instance
   * @returns {Promise<void>}
   */
  fitBounds: async function (swLat, swLon, neLat, neLon, duration, mapId) {
    return new Promise((resolve, reject) => {
      try {
        const map = window.yandexMaps[mapId];
        if (!map) return reject("Map not initialized.");
        const bounds = [
          [swLat, swLon],
          [neLat, neLon],
        ];
        map
          .setBounds(bounds, { duration: duration || 300 })
          .then(resolve)
          .catch(reject);
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Enables/disables scroll zoom interaction
   * @param {boolean} enabled - Whether to enable scroll zoom
   * @param {string} mapId - ID of target map instance
   * @returns {Promise<void>}
   */
  enableScrollZoom: async function (enabled, mapId) {
    return new Promise((resolve, reject) => {
      try {
        const map = window.yandexMaps[mapId];
        if (!map) return reject("Map not initialized.");
        map.behaviors[enabled ? "enable" : "disable"]("scrollZoom");
        resolve();
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Enables/disables map dragging
   * @param {boolean} enabled - Whether to enable dragging
   * @param {string} mapId - ID of target map instance
   * @returns {Promise<void>}
   */
  enableDrag: async function (enabled, mapId) {
    return new Promise((resolve, reject) => {
      try {
        const map = window.yandexMaps[mapId];
        if (!map) return reject("Map not initialized.");
        map.behaviors[enabled ? "enable" : "disable"]("drag");
        resolve();
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Changes base map type
   * @param {string} type - Map type ('map', 'satellite', 'hybrid')
   * @param {string} mapId - ID of target map instance
   * @returns {Promise<void>}
   */
  setMapType: async function (type, mapId) {
    return new Promise((resolve, reject) => {
      try {
        const map = window.yandexMaps[mapId];
        if (!map) return reject("Map not initialized.");
        map.setType(`yandex#${type}`);
        resolve();
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Adds new placemark to the map
   * @param {Array<number>} geometry - [longitude, latitude] coordinates
   * @param {Object} properties - Content properties
   * @param {Object} options - Display options
   * @param {string} mapId - ID of target map instance
   * @param {string} placemarkId - Unique identifier for placemark
   * @returns {Promise<void>}
   */
  addPlacemark: async function (
    geometry,
    properties,
    options,
    mapId,
    placemarkId
  ) {
    return new Promise((resolve, reject) => {
      try {
        const map = window.yandexMaps[mapId];
        if (!map) return reject("Map not initialized.");
        if (window.placemarks[placemarkId])
          return reject("Placemark already exists");

        const placemark = new ymaps.Placemark(geometry, properties, options);
        map.geoObjects.add(placemark);
        window.placemarks[placemarkId] = placemark;
        resolve();
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Removes a placemark from the map
   * @param {string} placemarkId - ID of the placemark to remove
   * @param {string} mapId - ID of the map instance
   * @returns {Promise<void>}
   */
  removePlacemark: async function (placemarkId, mapId) {
    return new Promise((resolve, reject) => {
      try {
        const map = window.yandexMaps[mapId];
        if (!map) return reject("Map not initialized.");
        const placemark = window.placemarks[placemarkId];
        if (!placemark) return reject("Placemark not found");

        map.geoObjects.remove(placemark);
        delete window.placemarks[placemarkId];
        resolve();
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Updates the coordinates of an existing placemark
   * @param {string} placemarkId - ID of the placemark to update
   * @param {Array<number>} newGeometry - New [longitude, latitude] coordinates
   * @returns {Promise<void>}
   */
  updatePlacemarkGeometry: async function (placemarkId, newGeometry) {
    return new Promise((resolve, reject) => {
      try {
        const placemark = window.placemarks[placemarkId];
        if (!placemark) return reject("Placemark not found");
        placemark.geometry.setCoordinates(newGeometry);
        resolve();
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Updates the content properties of an existing placemark
   * @param {string} placemarkId - ID of the placemark to update
   * @param {Object} newProperties - New content properties
   * @returns {Promise<void>}
   */
  updatePlacemarkProperties: async function (placemarkId, newProperties) {
    return new Promise((resolve, reject) => {
      try {
        const placemark = window.placemarks[placemarkId];
        if (!placemark) return reject("Placemark not found");
        placemark.properties.set(newProperties);
        resolve();
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Updates the display options of an existing placemark
   * @param {string} placemarkId - ID of the placemark to update
   * @param {Object} newOptions - New display options
   * @returns {Promise<void>}
   */
  updatePlacemarkOptions: async function (placemarkId, newOptions) {
    return new Promise((resolve, reject) => {
      try {
        const placemark = window.placemarks[placemarkId];
        if (!placemark) return reject("Placemark not found");
        placemark.options.set(newOptions);
        resolve();
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Adds a new polygon to the map
   * @param {Array<Array<number>>} geometry - Polygon coordinates array
   * @param {Object} properties - Content properties
   * @param {Object} options - Display options
   * @param {string} mapId - ID of the map instance
   * @param {string} polygonId - Unique ID for the polygon
   * @returns {Promise<void>}
   */
  addPolygon: async function (geometry, properties, options, mapId, polygonId) {
    return new Promise((resolve, reject) => {
      try {
        const map = window.yandexMaps[mapId];
        if (!map) return reject("Map not initialized yet.");
        if (window.polygons[polygonId]) return reject("Polygon already exists");

        const polygon = new ymaps.Polygon(geometry, properties, options);
        map.geoObjects.add(polygon);
        window.polygons[polygonId] = polygon;
        resolve();
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Removes a polygon from the map
   * @param {string} polygonId - ID of the polygon to remove
   * @param {string} mapId - ID of the map instance
   * @returns {Promise<void>}
   */
  removePolygon: async function (polygonId, mapId) {
    return new Promise((resolve, reject) => {
      try {
        const map = window.yandexMaps[mapId];
        if (!map) return reject("Map not initialized.");
        const polygon = window.polygons[polygonId];
        if (!polygon) return reject("Polygon not found");

        map.geoObjects.remove(polygon);
        delete window.polygons[polygonId];
        resolve();
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Updates the coordinates of an existing polygon
   * @param {string} polygonId - ID of the polygon to update
   * @param {Array<Array<number>>} newGeometry - New polygon coordinates
   * @returns {Promise<void>}
   */
  updatePolygonGeometry: async function (polygonId, newGeometry) {
    return new Promise((resolve, reject) => {
      try {
        const polygon = window.polygons[polygonId];
        if (!polygon) return reject("Polygon not found");
        polygon.geometry.setCoordinates(newGeometry);
        resolve();
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Updates the content properties of an existing polygon
   * @param {string} polygonId - ID of the polygon to update
   * @param {Object} newProperties - New content properties
   * @returns {Promise<void>}
   */
  updatePolygonProperties: async function (polygonId, newProperties) {
    return new Promise((resolve, reject) => {
      try {
        const polygon = window.polygons[polygonId];
        if (!polygon) return reject("Polygon not found");
        polygon.properties.set(newProperties);
        resolve();
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Updates the display options of an existing polygon
   * @param {string} polygonId - ID of the polygon to update
   * @param {Object} newOptions - New display options
   * @returns {Promise<void>}
   */
  updatePolygonOptions: async function (polygonId, newOptions) {
    return new Promise((resolve, reject) => {
      try {
        const polygon = window.polygons[polygonId];
        if (!polygon) return reject("Polygon not found");
        polygon.options.set(newOptions);
        resolve();
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Adds a new polyline to the map
   * @param {Array<Array<number>>} geometry - Polyline coordinates array
   * @param {Object} properties - Content properties
   * @param {Object} options - Display options
   * @param {string} mapId - ID of the map instance
   * @param {string} polylineId - Unique ID for the polyline
   * @returns {Promise<void>}
   */
  addPolyline: async function (
    geometry,
    properties,
    options,
    mapId,
    polylineId
  ) {
    return new Promise((resolve, reject) => {
      try {
        const map = window.yandexMaps[mapId];
        if (!map) return reject("Map not initialized.");
        if (window.polylines[polylineId])
          return reject("Polyline already exists");

        const pl = new ymaps.Polyline(geometry, properties, options);
        map.geoObjects.add(pl);
        window.polylines[polylineId] = pl;
        resolve();
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Removes a polyline from the map
   * @param {string} polylineId - ID of the polyline to remove
   * @param {string} mapId - ID of the map instance
   * @returns {Promise<void>}
   */
  removePolyline: async function (polylineId, mapId) {
    return new Promise((resolve, reject) => {
      try {
        const map = window.yandexMaps[mapId];
        if (!map) return reject("Map not initialized.");
        const pl = window.polylines[polylineId];
        if (!pl) return reject("Polyline not found");

        map.geoObjects.remove(pl);
        delete window.polylines[polylineId];
        resolve();
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Updates the coordinates of an existing polyline
   * @param {string} polylineId - ID of the polyline to update
   * @param {Array<Array<number>>} newGeometry - New polyline coordinates
   * @returns {Promise<void>}
   */
  updatePolylineGeometry: async function (polylineId, newGeometry) {
    return new Promise((resolve, reject) => {
      try {
        const pl = window.polylines[polylineId];
        if (!pl) return reject("Polyline not found");
        pl.geometry.setCoordinates(newGeometry);
        resolve();
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Updates the content properties of an existing polyline
   * @param {string} polylineId - ID of the polyline to update
   * @param {Object} newProps - New content properties
   * @returns {Promise<void>}
   */
  updatePolylineProperties: async function (polylineId, newProps) {
    return new Promise((resolve, reject) => {
      try {
        const pl = window.polylines[polylineId];
        if (!pl) return reject("Polyline not found");
        pl.properties.set(newProps);
        resolve();
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Updates the display options of an existing polyline
   * @param {string} polylineId - ID of the polyline to update
   * @param {Object} newOpts - New display options
   * @returns {Promise<void>}
   */
  updatePolylineOptions: async function (polylineId, newOpts) {
    return new Promise((resolve, reject) => {
      try {
        const pl = window.polylines[polylineId];
        if (!pl) return reject("Polyline not found");
        pl.options.set(newOpts);
        resolve();
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Performs geocoding operation (address to coordinates or reverse)
   * @param {string|Array<number>} request - Address string or [lon, lat] coordinates
   * @param {Object} options - Geocoding options
   * @returns {Promise<Array<JsGeocodeResult>>} Array of geocoding results
   */
  geocode: async function (request, options = {}) {
    return new Promise((resolve, reject) => {
      try {
        ymaps
          .geocode(request, options)
          .then((result) => {
            const members = result.geoObjects.toArray();

            const parsed = members.map((obj) => {
              const coords = obj.geometry.getCoordinates();
              return new JsGeocodeResult(
                coords[1],
                coords[0],
                obj.properties.get("name"),
                obj.properties.get("description")
              );
            });

            resolve(parsed);
          })
          .catch((err) => {
            console.error("GEOCODE ERROR", err);
            reject(err);
          });
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   * Performs address suggestion (autocomplete)
   * @param {string} request - Partial address input
   * @param {Object} options - Suggestion options
   * @returns {Promise<Array<JsSuggestResult>>} Array of suggestion results
   */
  suggest: async function (request, options = {}) {
    return new Promise((resolve, reject) => {
      try {
        ymaps
          .suggest(request, options)
          .then((result) => {
            const parsed = result.map((obj) => {
              return new JsSuggestResult(obj.displayName, obj.value);
            });
            resolve(parsed);
          })
          .catch((err) => {
            console.error("SUGGEST ERROR", err);
            reject(err);
          });
      } catch (e) {
        reject(e);
      }
    });
  },
};
