// infocard.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Pages/map.dart'; // Adjust path if necessary

// Extract constants
const double _kPadding = 16.0;
const double _kBorderRadius = 8.0;
const int _kAnimationDuration = 300;
const double _kMaxCardHeight = 500.0; // Maximum height for the expanded card

class ExpandableFarmCard extends StatefulWidget {
  final double area;
  final AreaUnit selectedUnit;
  final List<String> recommendedCrops;
  final Map<String, Map<String, double>> fertilizerRecommendations;
  final VoidCallback onClearArea;
  final Function(AreaUnit) onUnitChanged;
  final VoidCallback onSavePlot;
  final bool isDrawing;

  const ExpandableFarmCard({
    super.key,
    required this.area,
    required this.selectedUnit,
    required this.recommendedCrops,
    required this.fertilizerRecommendations,
    required this.onClearArea,
    required this.onUnitChanged,
    required this.onSavePlot,
    required this.isDrawing,
  });

  @override
  State<ExpandableFarmCard> createState() => _ExpandableFarmCardState();
}

class _ExpandableFarmCardState extends State<ExpandableFarmCard>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late final AnimationController _controller;
  late final Animation<double> _heightFactor;
  final ScrollController _scrollController = ScrollController();

  static final cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(_kBorderRadius),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: _kAnimationDuration),
      vsync: this,
    );
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  String _getFormattedArea() {
    double displayedArea = widget.area;
    switch (widget.selectedUnit) {
      case AreaUnit.acres:
        displayedArea *= 2.47105;
        break;
      case AreaUnit.squareMeters:
        displayedArea *= 10000;
        break;
      case AreaUnit.hectares:
        break;
    }

     String unitString = '';
    switch (widget.selectedUnit) {
      case AreaUnit.acres:
        unitString = 'Acres';
        break;
      case AreaUnit.squareMeters:
        unitString = 'Sq Meters';
        break;
      case AreaUnit.hectares:
      default:
        unitString = 'Hectares';
        break;
    }

    return '${NumberFormat('#,##0.00').format(displayedArea)} $unitString';
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isDrawing && !isExpanded) {
      return _buildFloatingIndicator();
    }

    return Positioned(
      bottom: _kPadding,
      left: _kPadding,
      right: _kPadding,
      child: _buildMainCard(),
    );
  }

  Widget _buildFloatingIndicator() {
    return Positioned(
      top: _kPadding,
      right: _kPadding,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(_kBorderRadius),
        child: InkWell(
          onTap: _toggleExpanded,
          borderRadius: BorderRadius.circular(_kBorderRadius),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: _kPadding, vertical: 12),
            decoration: cardDecoration,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.area_chart, size: 20, color: Colors.green[700]),
                const SizedBox(width: 8),
                Text(
                  _getFormattedArea(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.green[700],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.expand_more, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainCard() {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! > 0 && isExpanded) {
          _toggleExpanded();
        }
      },
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.zero,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_kBorderRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDragHandle(),
            _buildHeader(),
            // _buildAreaDisplay(),
            if (isExpanded) _buildExpandedContent(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedContent() {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: _kMaxCardHeight),
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            _buildAreaDisplay(),
            _buildRecommendedCrops(),
            _buildFertilizerGuide(),
          ],
        ),
      ),
    );
  }

  Widget _buildDragHandle() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader() {
    return ListTile(
      title: Row(
        children: [
          const Text(
            'Farm Area Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const Spacer(),
          _buildUnitDropdown(),
        ],
      ),
      trailing: IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _controller,
        ),
        onPressed: _toggleExpanded,
      ),
    );
  }

  Widget _buildUnitDropdown() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[100],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButton<AreaUnit>(
        value: widget.selectedUnit,
        underline: const SizedBox(),
        items: AreaUnit.values.map((unit) {
          return DropdownMenuItem(
            value: unit,
            child: Text(
              unit.toString().split('.').last,
              style: const TextStyle(fontSize: 14),
            ),
          );
        }).toList(),
        onChanged: (value) => widget.onUnitChanged(value!),
      ),
    );
  }

  Widget _buildAreaDisplay() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total Area',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          Text(
            _getFormattedArea(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedCrops() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recommended Crops',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.recommendedCrops.map((crop) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green[100]!),
                ),
                child: Text(
                  crop,
                  style: TextStyle(
                    color: Colors.green[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFertilizerGuide() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fertilizer Guide',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...widget.fertilizerRecommendations.entries.map((cropEntry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cropEntry.key,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                ...cropEntry.value.entries.map((fert) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue[100]!),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                fert.key,
                                style: TextStyle(
                                  color: Colors.blue[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              '${fert.value.toStringAsFixed(1)} kg/ha',
                              style: TextStyle(
                                color: Colors.blue[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: fert.value / 200,
                            backgroundColor: Colors.blue[100],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.blue[700]!,
                            ),
                            minHeight: 8,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 16),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16), // Reduced top padding
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: widget.onClearArea,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[100],
                foregroundColor: Colors.red[700],
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Clear Area'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: widget.onSavePlot,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Save Plot'),
            ),
          ),
        ],
      ),
    );
  }
}