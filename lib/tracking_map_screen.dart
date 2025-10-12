import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class TrackingMapScreen extends StatefulWidget {
  // Tambahkan parameter opsional untuk lokasi tujuan
  final LatLng? destination;

  const TrackingMapScreen({super.key, this.destination});

  @override
  State<TrackingMapScreen> createState() => _TrackingMapScreenState();
}

class _TrackingMapScreenState extends State<TrackingMapScreen> {
  late final MapController _mapController;
  
  // Mode 1: State untuk Mode Pelacakan Rute
  final LatLng _packageLocation = const LatLng(-7.657, 111.352); // <-- DIUBAH KE MAGETAN
  List<LatLng> _routePoints = [];
  bool _isLoadingRoute = true;

  // Mode 2: State untuk Mode Pemilihan Lokasi
  LatLng? _selectedLocation;

  // Cek mode berdasarkan parameter constructor
  bool get _isSelectionMode => widget.destination == null;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    if (_isSelectionMode) {
      // Mode Pemilihan: Set lokasi awal di Jakarta untuk memudahkan pencarian
      _selectedLocation = const LatLng(-6.2088, 106.8456);
    } else {
      // Mode Pelacakan: Ambil rute dari Magetan ke tujuan
      _fetchRoute();
    }
  }

  // --- LOGIKA UNTUK MODE PELACAKAN RUTE ---
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

  // --- LOGIKA UNTUK MODE PEMILIHAN LOKASI ---
  void _handleTap(TapPosition tapPosition, LatLng latlng) {
    if (!_isSelectionMode) return;
    setState(() {
      _selectedLocation = latlng;
    });
  }

  void _confirmSelection() {
    if (_selectedLocation != null) {
      Navigator.pop(context, _selectedLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isSelectionMode ? 'Pilih Lokasi Pengiriman' : 'Lacak Pesanan Anda'),
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
              // Tampilkan rute jika dalam mode pelacakan
              if (!_isSelectionMode)
                PolylineLayer(
                  polylines: [Polyline(points: _routePoints, strokeWidth: 4.0, color: Colors.blue)],
                ),
              // Tampilkan marker sesuai mode
              MarkerLayer(
                markers: _buildMarkers(),
              ),
            ],
          ),
          // Tampilkan banner info jika dalam mode pemilihan
          if (_isSelectionMode)
            Positioned(
              top: 0, left: 0, right: 0,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.all(8.0),
                child: const Text('Ketuk pada peta untuk memilih lokasi pengiriman.', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
              ),
            ),
          // Tampilkan loading indicator saat mengambil rute
          if (!_isSelectionMode && _isLoadingRoute)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(child: CircularProgressIndicator()),
            ),
          // Tombol Zoom
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
