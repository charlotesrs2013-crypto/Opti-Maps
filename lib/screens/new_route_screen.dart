import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/route_model.dart';
import '../models/stop_model.dart';
import '../providers/route_provider.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import '../widgets/app_text_field.dart';

class NewRouteScreen extends StatefulWidget {
  const NewRouteScreen({super.key});

  @override
  State<NewRouteScreen> createState() => _NewRouteScreenState();
}

class _NewRouteScreenState extends State<NewRouteScreen> {
final TextEditingController routeNameController =
TextEditingController();

final TextEditingController addressController =
TextEditingController();

final List<StopModel> stops = [];

@override
void dispose() {
routeNameController.dispose();
addressController.dispose();
super.dispose();
}

// =====================================================
// Métodos
// =====================================================

void _addStop() {
if (addressController.text.trim().isEmpty) {
return;
}

setState(() {
stops.add(
StopModel(
routeId: 0,
order: stops.length + 1,
address: addressController.text.trim(),
),
);

addressController.clear();
});
}

Future<void> _saveRoute() async {
if (routeNameController.text.trim().isEmpty) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text("Digite o nome da rota."),
),
);
return;
}

if (stops.isEmpty) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text("Adicione pelo menos um endereço."),
),
);
return;
}

final route = RouteModel(
name: routeNameController.text.trim(),
createdAt: DateTime.now(),
updatedAt: DateTime.now(),
);

await context.read<RouteProvider>().saveRoute(
route,
stops,
);

if (!mounted) return;

ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text("Rota salva com sucesso!"),
),
);

Navigator.pop(context);
}

// =====================================================
// Interface
// =====================================================

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text("Nova Rota"),
),
body: ListView(
padding: const EdgeInsets.all(16),
children: [
_buildRouteNameField(),

const SizedBox(height: 16),

_buildAddressField(),

const SizedBox(height: 12),

_buildAddButton(),

const SizedBox(height: 24),

const Text(
"Paradas",
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 12),

_buildStopsList(),

const SizedBox(height: 24),

_buildSaveButton(),
],
),
);
}

Widget _buildRouteNameField() {
return AppTextField(
controller: routeNameController,
label: "Nome da rota",
prefixIcon: Icons.route,
);
}

Widget _buildAddressField() {
return AppTextField(
controller: addressController,
label: "Endereço",
hint: "Digite um endereço",
prefixIcon: Icons.location_on,
);
}

Widget _buildAddButton() {
return AppButton(
text: "Adicionar Endereço",
icon: Icons.add_location_alt,
onPressed: _addStop,
);
}
  Widget _buildStopsList() {
    if (stops.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: Text(
            "Nenhum endereço adicionado.",
          ),
        ),
      );
    }

    return Column(
      children: List.generate(
        stops.length,
            (index) => _buildStopCard(index),
      ),
    );
  }

  Widget _buildStopCard(int index) {
    final stop = stops[index];

    return AppCard(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          child: Text("${index + 1}"),
        ),
        title: Text(stop.address),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            setState(() {
              stops.removeAt(index);

              for (int i = 0; i < stops.length; i++) {
                stops[i].order = i + 1;
              }
            });
          },
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return AppButton(
      text: "Salvar Rota",
      icon: Icons.save,
      onPressed: _saveRoute,
    );
  }
}