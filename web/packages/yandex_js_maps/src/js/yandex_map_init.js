/**
 * Initializes and configures a Yandex Map instance with specified parameters.
 *
 * @param {string} mapId - The ID of the HTML container element for the map
 * @param {Object} [state={}] - Initial map state configuration:
 * @param {Array<number>} state.center - [latitude, longitude] coordinates
 * @param {number} state.zoom - Initial zoom level
 * @param {Object} [options={}] - Map behavior and display options
 * @param {Array<Object>} placemarks - Array of placemark configurations:
 * @param {Array<number>} placemarks.geometry - [latitude, longitude] coordinates
 * @param {Object} placemarks.properties - Placemark content properties
 * @param {Object} placemarks.options - Placemark display options
 * @param {Array<Object>} polygons - Array of polygon configurations:
 * @param {Array<Array<number>>} polygons.geometry - Polygon coordinates
 * @param {Object} polygons.properties - Polygon content properties
 * @param {Object} polygons.options - Polygon display options
 * @param {Array<Object>} polylines - Array of polyline configurations:
 * @param {Array<Array<number>>} polylines.geometry - Polyline coordinates
 * @param {Object} polylines.properties - Polyline content properties
 * @param {Object} polylines.options - Polyline display options
 */
function initYandexMap(
  mapId,
  state = {},
  options = {},
  placemarks,
  polygons,
  polylines
) {
  /**
   * Waits for the map container element to be available in DOM before initialization.
   * Uses recursive setTimeout to avoid blocking the main thread.
   */
  function waitForContainer() {
    const mapContainer = document.getElementById(mapId);
    if (!mapContainer) {
      setTimeout(waitForContainer, 100);
      return;
    }

    ymaps.ready(function () {
      // Initialize maps registry if not exists
      if (!window.yandexMaps) window.yandexMaps = {};

      // Skip if map already initialized
      if (window.yandexMaps[mapId]) return;

      // Create new map instance
      const map = new ymaps.Map(mapId, state, options);

      // Add placemarks to map
      placemarks.forEach((pm) => {
        const placemark = new ymaps.Placemark(
          pm.geometry,
          pm.properties || {},
          pm.options || {}
        );
        map.geoObjects.add(placemark);
        if (!window.placemarks) window.placemarks = {};
        window.placemarks[pm.id] = placemark;
      });

      // Add polygons to map
      polygons.forEach((poly) => {
        const polygon = new ymaps.Polygon(
          poly.geometry,
          poly.properties || {},
          poly.options || {}
        );
        map.geoObjects.add(polygon);
        if (!window.polygons) window.polygons = {};
        window.polygons[poly.id] = polygon;
      });

      // Add polylines to map
      polylines.forEach((line) => {
        const polyline = new ymaps.Polyline(
          line.geometry,
          line.properties || {},
          line.options || {}
        );
        map.geoObjects.add(polyline);
        if (!window.polylines) window.polylines = {};
        window.polylines[line.id] = polyline;
      });

      // Store map reference in global registry
      window.yandexMaps[mapId] = map;
    });
  }

  waitForContainer();
}

/**
 * Destroys a Yandex Map instance and cleans up associated resources
 * @param {string} mapId - The ID of the map container
 * @param {Array<string>} placemarksIds - List of placemark IDs to remove
 * @param {Array<string>} polygonsIds - List of polygon IDs to remove
 * @param {Array<string>} polylinesIds - List of polyline IDs to remove
 */
function destroyYandexMap(mapId, placemarksIds, polygonsIds, polylinesIds) {
  if (window.yandexMaps && window.yandexMaps[mapId]) {
    // Destroy the map instance
    window.yandexMaps[mapId].destroy();
    delete window.yandexMaps[mapId];

    // Clean up associated objects (assuming we track them by mapId)
    for (const id of placemarksIds) {
      if (window.placemarks[id]) delete window.placemarks[id];
    }

    // Similar cleanup for polygons and polylines
    for (const id of polygonsIds) {
      if (window.polygons[id]) delete window.polygons[id];
    }

    for (const id of polylinesIds) {
      if (window.polylines[id]) delete window.polylines[id];
    }
  }
}
