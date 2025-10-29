import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class TrackingMapScreen extends StatefulWidget {
  final LatLng? destination;

  const TrackingMapScreen({super.key, this.destination});

  @override
  State<TrackingMapScreen> createState() => _TrackingMapScreenState();
}

class _TrackingMapScreenState extends State<TrackingMapScreen> {
  late final MapController _mapController;
  
  final LatLng _packageLocation = const LatLng(-7.657, 111.352);
  List<LatLng> _routePoints = [];
  bool _isLoadingRoute = true;

  LatLng? _selectedLocation;

  // Weather state variables
  String? _temperature;
  int? _weatherCode;
  bool _isLoadingWeather = true;
  String? _weatherError;

  bool get _isSelectionMode => widget.destination == null;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    if (_isSelectionMode) {
      _selectedLocation = const LatLng(-6.2088, 106.8456); // Default Jakarta
      _fetchWeather(_selectedLocation!); // Fetch weather for the initial selected location
    } else {
      _fetchRoute();
      _fetchWeather(widget.destination!); // Fetch weather for the destination
    }
  }

  Future<void> _fetchRoute() async {
    if (widget.destination == null) return;

    setState(() {
      _isLoadingRoute = true;
    });

    final start = _packageLocation;
    final end = widget.destination!;
    final url = 'http://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?overview=full&geometries=geojson';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> coordinates = data['routes'][0]['geometry']['coordinates'];
        setState(() {
          _routePoints = coordinates.map((c) => LatLng(c[1], c[0])).toList();
        });
      } else {
        print('Failed to load route: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching route: $e');
    }
    setState(() {
      _isLoadingRoute = false;
    });
  }

  Future<void> _fetchWeather(LatLng location) async {
    setState(() {
      _isLoadingWeather = true;
      _weatherError = null;
    });

    final url = 'https://api.open-meteo.com/v1/forecast?latitude=${location.latitude}&longitude=${location.longitude}&current_weather=true';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final currentWeather = data['current_weather'];
        setState(() {
          _temperature = currentWeather['temperature'].toString();
          _weatherCode = currentWeather['weathercode'] as int?;
        });
      } else {
        setState(() {
          _weatherError = "Failed to load weather";
        });
      }
    } catch (e) {
      setState(() {
        _weatherError = "Network error";
      });
    }
    setState(() {
      _isLoadingWeather = false;
    });
  }

  void _handleTap(TapPosition tapPosition, LatLng latlng) {
    if (!_isSelectionMode) return;
    setState(() {
      _selectedLocation = latlng;
    });
    _fetchWeather(latlng); // **MODIFIED: Fetch weather on every tap in selection mode**
  }

  void _confirmSelection() {
    if (_selectedLocation != null) {
      Navigator.pop(context, _selectedLocation);
    }
  }

  IconData _getWeatherIcon(int? code) {
    if (code == null) return Icons.device_unknown;
    switch (code) {
      case 0: return Icons.wb_sunny; // Clear sky
      case 1: return Icons.wb_cloudy; // Mainly clear
      case 2: return Icons.cloud; // Partly cloudy
      case 3: return Icons.cloud_off; // Overcast
      case 45: case 48: return Icons.foggy; // Fog
      case 51: case 53: case 55: return Icons.grain; // Drizzle
      case 61: case 63: case 65: return Icons.water_drop; // Rain
      case 66: case 67: return Icons.ac_unit; // Freezing Rain
      case 71: case 73: case 75: return Icons.snowing; // Snow fall
      case 80: case 81: case 82: return Icons.shower; // Rain showers
      case 85: case 86: return Icons.snowshoeing; // Snow showers
      case 95: case 96: case 99: return Icons.thunderstorm; // Thunderstorm
      default: return Icons.wb_sunny;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isSelectionMode ? 'Pilih Lokasi Penerima Pesanan' : 'Lacak Pesanan Anda'),
        actions: [
          if (_isSelectionMode)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _confirmSelection,
              tooltip: 'Konfirmasi Lokasi',
            )
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _isSelectionMode ? _selectedLocation! : const LatLng(-2.5489, 118.0149),
              initialZoom: _isSelectionMode ? 11.0 : 5.5,
              onTap: _handleTap,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.yaelah',
              ),
              if (!_isSelectionMode)
                PolylineLayer(
                  polylines: [Polyline(points: _routePoints, strokeWidth: 4.0, color: Colors.blue)],
                ),
              MarkerLayer(
                markers: _buildMarkers(),
              ),
            ],
          ),
          if (_isSelectionMode)
            Positioned(
              top: 0, left: 0, right: 0,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.all(8.0),
                child: const Text('Ketuk pada peta untuk memilih lokasi penerima pesanan.', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
              ),
            ),
          if (!_isSelectionMode && _isLoadingRoute)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(child: CircularProgressIndicator()),
            ),
          // **MODIFIED: Weather overlay is now always visible**
          Positioned(
            top: _isSelectionMode ? 50 : 10, // Adjust position for selection mode banner
            left: 10,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: _isLoadingWeather
                    ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 3))
                    : _weatherError != null
                        ? Row(children: [const Icon(Icons.error_outline, color: Colors.red), const SizedBox(width: 8), Text(_weatherError!)])
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(_getWeatherIcon(_weatherCode), color: Colors.blueAccent, size: 28),
                              const SizedBox(width: 8),
                              Text(
                                '${_temperature ?? '--'}°C',
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
              ),
            ),
          ),
          Positioned(
            bottom: 20, right: 20,
            child: Column(
              children: [
                FloatingActionButton(heroTag: 'zoom_in', mini: true, onPressed: () => _mapController.move(_mapController.center, _mapController.zoom + 1), child: const Icon(Icons.add)),
                const SizedBox(height: 8),
                FloatingActionButton(heroTag: 'zoom_out', mini: true, onPressed: () => _mapController.move(_mapController.center, _mapController.zoom - 1), child: const Icon(Icons.remove)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Marker> _buildMarkers() {
    if (_isSelectionMode) {
      return _selectedLocation == null ? [] : [
        Marker(
          width: 80.0, height: 80.0, point: _selectedLocation!,
          child: const Icon(Icons.location_on, color: Colors.red, size: 40.0),
        ),
      ];
    } else {
      return [
        Marker(
          width: 80.0, height: 80.0, point: _packageLocation,
          child: const Column(children: [Icon(Icons.location_on, color: Colors.blue, size: 40.0), Text("Paket", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold))]),
        ),
        if (widget.destination != null)
          Marker(
            width: 80.0, height: 80.0, point: widget.destination!,
            child: const Column(children: [Icon(Icons.location_on, color: Colors.red, size: 40.0), Text("Tujuan", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))]),
          ),
      ];
    }
  }
}
