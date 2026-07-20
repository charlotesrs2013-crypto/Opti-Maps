import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/route_model.dart';
import '../models/stop_model.dart';
import '../providers/route_provider.dart';

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

void addAddress() {
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

Future<void> saveRoute() async {
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

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text("Nova Rota"),
centerTitle: true,
),
body: Padding(
padding: const EdgeInsets.all(20),
child: Column(
children: [

TextField(
controller: routeNameController,
decoration: const InputDecoration(
labelText: "Nome da rota",
border: OutlineInputBorder(),
),
),

const SizedBox(height: 20),

TextField(
controller: addressController,
decoration: const InputDecoration(
labelText: "Endereço",
border: OutlineInputBorder(),
),
),

const SizedBox(height: 15),

SizedBox(
width: double.infinity,
child: ElevatedButton(
onPressed: addAddress,
child: const Text("Adicionar Endereço"),
),
),

const SizedBox(height: 20),

const Align(
alignment: Alignment.centerLeft,
child: Text(
"Paradas",
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
),
),
),

const SizedBox(height: 10),

Expanded(
child: stops.isEmpty
    ? const Center(
  child: Text("Nenhum endereço adicionado."),
)
    : ListView.builder(
  itemCount: stops.length,
  itemBuilder: (context, index) {
    final stop = stops[index];

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text("${index + 1}"),
        ),
        title: Text(stop.address),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
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
  },
),
),

  const SizedBox(height: 15),

  SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: saveRoute,
      icon: const Icon(Icons.save),
      label: const Text("Salvar Rota"),
    ),
  ),
],
),
),
);
}
}