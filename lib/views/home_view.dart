import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mwi_chest_sim/models/item_models/item.dart';
import 'package:mwi_chest_sim/views/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void dispose() {
    context.read<HomeViewModel>().chestQuantityEditingController.dispose();
    context.read<HomeViewModel>().clearTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (MediaQuery.of(context).size.width > 900) {
              return pcViewForLayout();
            } else {
              return mobileViewForLayout();
            }
          },
        ));
  }

  SafeArea mobileViewForLayout() {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          const Row(
            children: [
              Spacer(),
              Expanded(flex: 7, child: ExpensesToggleButtons()),
              Spacer(),
              Expanded(flex: 7, child: DropsToggleButtons()),
              Spacer(),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          const Row(
            children: [
              Spacer(),
              Expanded(flex: 8, child: ClearTimeWidget()),
              Spacer()
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          const Row(
            children: [
              Spacer(),
              Expanded(flex: 8, child: EconomicsTable()),
              Spacer()
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  flex: 2,
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: ChestSelectionWidget(),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                const Expanded(
                  flex: 1,
                  child: AspectRatio(
                    aspectRatio: 4 / 1,
                    child: ChestCountTextField(),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: AspectRatio(
                    aspectRatio: 4 / 1,
                    child: ChestQuantityButton(),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                const Expanded(
                  child: SimulationProgressIndicator(),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              ],
            ),
          ),
          const ChestResultsGridView(),
          const ItemPricesTable(),
        ],
      ),
    ));
  }

  SafeArea pcViewForLayout() {
    return SafeArea(
      child: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover),
          ),
        ),
        const Row(
          children: [
            Flexible(
              child: Column(
                children: [
                  Spacer(),
                  Flexible(
                      flex: 4,
                      child: Row(
                        children: [
                          Spacer(),
                          Expanded(flex: 8, child: ClearTimeWidget()),
                          Spacer(),
                        ],
                      )),
                  Spacer(),
                  Flexible(
                    flex: 4,
                    child: Row(
                      children: [
                        Spacer(),
                        Flexible(flex: 8, child: EconomicsTable()),
                        Spacer(),
                      ],
                    ),
                  ),
                  Spacer(),
                  Flexible(
                    flex: 4,
                    child: Column(
                      children: [
                        ExpensesToggleButtons(),
                        DropsToggleButtons(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Expanded(
                    flex: 16,
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: ChestSelectionWidget(),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 8,
                    child: AspectRatio(
                      aspectRatio: 4 / 1,
                      child: ChestCountTextField(),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Spacer(),
                        Flexible(
                          child: AspectRatio(
                            aspectRatio: 4 / 1,
                            child: ChestQuantityButton(),
                          ),
                        ),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 4 / 1,
                            child: SimulationProgressIndicator(),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 120,
                    child: ChestResultsGridView(),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ItemPricesTable(),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

class ExpensesToggleButtons extends StatefulWidget {
  const ExpensesToggleButtons({super.key});

  @override
  State<ExpensesToggleButtons> createState() => _ExpensesToggleButtons();
}

class _ExpensesToggleButtons extends State<ExpensesToggleButtons> {
  List<bool> expensesIsSelected = [true, false];

  void changeSelectedButton(int newIndex) {
    return setState(() {
      for (int index = 0; index < expensesIsSelected.length; index++) {
        if (index == newIndex) {
          if (expensesIsSelected[index] == false) {
            expensesIsSelected[index] = !expensesIsSelected[index];
          }
        } else {
          expensesIsSelected[index] = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSizes = MediaQuery.of(context).size;
    final viewModel = context.read<HomeViewModel>();

    void changeExpenseType(newIndex) {
      if (newIndex == 0) {
        viewModel.areExpensesCalculatedFromAsk = true;
      } else {
        viewModel.areExpensesCalculatedFromAsk = false;
      }
    }

    double responsiveWidthMultiplier() {
      if (screenSizes.width > 900) {
        return 0.07;
      } else {
        return 0.2;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Expense prices",
        ),
        SizedBox(
          height: screenSizes.height * 0.07,
          child: ToggleButtons(
            selectedBorderColor: Theme.of(context).colorScheme.onSurface,
            selectedColor: Colors.white,
            fillColor: Theme.of(context).colorScheme.primary,
            onPressed: (index) {
              changeSelectedButton(index);
              changeExpenseType(index);
              viewModel.calculateAllEconomics();
            },
            isSelected: expensesIsSelected,
            children: [
              SizedBox(
                  width: screenSizes.width * responsiveWidthMultiplier(),
                  child: const Text(
                    "Ask",
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                width: screenSizes.width * responsiveWidthMultiplier(),
                child: const Text(
                  "Bid",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DropsToggleButtons extends StatefulWidget {
  const DropsToggleButtons({super.key});

  @override
  State<DropsToggleButtons> createState() => _DropsToggleButtons();
}

class _DropsToggleButtons extends State<DropsToggleButtons> {
  List<bool> dropsIsSelected = [true, false];

  void changeSelectedButton(int newIndex) {
    return setState(() {
      for (int index = 0; index < dropsIsSelected.length; index++) {
        if (index == newIndex) {
          if (dropsIsSelected[index] == false) {
            dropsIsSelected[index] = !dropsIsSelected[index];
          }
        } else {
          dropsIsSelected[index] = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSizes = MediaQuery.of(context).size;
    final viewModel = context.read<HomeViewModel>();

    void changeExpenseType(newIndex) {
      if (newIndex == 0) {
        viewModel.areDropsCalculatedFromAsk = true;
      } else {
        viewModel.areDropsCalculatedFromAsk = false;
      }
    }

    double responsiveWidthMultiplier() {
      if (screenSizes.width > 900) {
        return 0.07;
      } else {
        return 0.2;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Drop prices"),
        SizedBox(
          height: screenSizes.height * 0.07,
          child: ToggleButtons(
            selectedBorderColor: Theme.of(context).colorScheme.onSurface,
            selectedColor: Colors.white,
            fillColor: Theme.of(context).colorScheme.primary,
            onPressed: (index) {
              changeSelectedButton(index);
              changeExpenseType(index);
              viewModel.calculateAllEconomics();
            },
            isSelected: dropsIsSelected,
            children: [
              SizedBox(
                  width: screenSizes.width * responsiveWidthMultiplier(),
                  child: const Text(
                    "Ask",
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                width: screenSizes.width * responsiveWidthMultiplier(),
                child: const Text(
                  "Bid",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SimulationProgressIndicator extends StatelessWidget {
  const SimulationProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final simulationProgress = context.select<HomeViewModel, double>(
        (viewModel) => viewModel.currentSimulationProgress);
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(right: 2.0),
      child: LinearProgressIndicator(
        borderRadius: BorderRadius.circular(height * 0.01),
        value: simulationProgress,
        backgroundColor: Colors.grey,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class ClearTimeWidget extends StatelessWidget {
  const ClearTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSizes = MediaQuery.of(context).size;
    final textFieldController =
        context.read<HomeViewModel>().clearTimeController;
    final viewModel = context.read<HomeViewModel>();

    double responsiveHeightMultiplier() {
      if (screenSizes.width > 900) {
        return 0.07;
      } else {
        return 0.05;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Align(
            alignment: Alignment.center, child: Text("Clear time in minutes")),
        SizedBox(
          height: screenSizes.height * responsiveHeightMultiplier(),
          child: TextField(
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            controller: textFieldController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(0),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(
          height: screenSizes.height * responsiveHeightMultiplier(),
          child: FilledButton(
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(screenSizes.height * 0.01),
                ),
              ),
            ),
            onPressed: () {
              if(textFieldController.text.isNotEmpty){
              viewModel.updateClearTimeInMinutes(
                  int.parse(textFieldController.text));
              viewModel.calculateAllEconomics();
              } 
            },
            child: const Text("SET"),
          ),
        ),
      ],
    );
  }
}

class ChestSelectionWidget extends StatelessWidget {
  const ChestSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentChest = context
        .select<HomeViewModel, String>((viewModel) => viewModel.currentChest);
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return const ChestChoosingDialog();
          },
        );
      },
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
          ),
          child: ItemBox(itemName: currentChest)),
    );
  }
}

class ChestResultsGridView extends StatelessWidget {
  const ChestResultsGridView({super.key});

  //decide height of the gridview responsively if screen
  //is probably a mobile view.
  double? responsiveHeight(Size sizes, int itemCount) {
    if (sizes.width > 900) {
      return null;
    } else {
      return (itemCount / 5).ceil() * (sizes.width * 0.20);
    }
  }

  //if screen is mobile view gridview is unscrollable. It already has
  //enough space to show its content and it makes general scrolling in the page
  //harder if scrolling is on
  NeverScrollableScrollPhysics? isScrollable(Size sizes) {
    if (sizes.width > 900) {
      return null;
    } else {
      return const NeverScrollableScrollPhysics();
    }
  }

  @override
  Widget build(BuildContext context) {
    final chestDrops = context.select<HomeViewModel, Map<String, Item>>(
        (viewModel) => viewModel.chestDrops);
    final sizes = MediaQuery.of(context).size;
    return SizedBox(
      height: responsiveHeight(sizes, chestDrops.length),
      child: GridView.builder(
        physics: isScrollable(sizes),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        itemCount: chestDrops.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.fromLTRB(2, 0, 2, 4),
              child: ItemBox.fromMapEntry(
                  mapEntry: chestDrops.entries.elementAt(index)));
        },
      ),
    );
  }
}

class ChestQuantityButton extends StatelessWidget {
  const ChestQuantityButton({super.key});

  final buttonText = "OPEN";

  @override
  Widget build(BuildContext context) {
    final screenSizes = MediaQuery.of(context).size;
    final homeViewModel = context.read<HomeViewModel>();
    final isButtonDisabled = context.select<HomeViewModel, bool>(
        (viewModel) => viewModel.isSimulationOnProgress);
    return FilledButton(
      style: ButtonStyle(
        backgroundColor:
            isButtonDisabled ? WidgetStateProperty.all(Colors.grey) : null,
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenSizes.height * 0.01),
          ),
        ),
      ),
      onPressed: () {
        if (!isButtonDisabled && homeViewModel.chestQuantityEditingController.text.isNotEmpty) {
          homeViewModel.openChest(
              int.parse(homeViewModel.chestQuantityEditingController.text));
        }
      },
      child: Text(buttonText),
    );
  }
}

class ItemPricesTable extends StatelessWidget {
  const ItemPricesTable({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeViewModel>();
    final chestDrops = context.select<HomeViewModel, Map<String, Item>>(
        (viewModel) => viewModel.chestDrops);

    return SingleChildScrollView(
      child: FittedBox(
        child: DataTable(
          border: const TableBorder(
            verticalInside: BorderSide(color: Colors.white),
          ),
          columns: const [
            DataColumn(label: Text("Item")),
            DataColumn(label: Text("Quantity")),
            DataColumn(label: Text("Ask")),
            DataColumn(label: Text("Bid")),
          ],
          rows: chestDrops.entries
              .map(
                (e) => DataRow(
                  cells: [
                    DataCell(Text(e.key.toString())),
                    DataCell(Text(
                        viewModel.formatInteger(e.value.quantity.toString()))),
                    DataCell(Text(viewModel
                        .formatInteger(e.value.prices!.ask.toString()))),
                    DataCell(Text(viewModel
                        .formatInteger(e.value.prices!.bid.toString()))),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class EconomicsTable extends StatelessWidget {
  const EconomicsTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeViewModel>();
    final totalRevenue = context
        .select<HomeViewModel, double>((viewModel) => viewModel.totalRevenue);
    final totalExpense = context
        .select<HomeViewModel, double>((viewModel) => viewModel.totalExpense);

    final totalProfit = context
        .select<HomeViewModel, double>((viewModel) => viewModel.totalProfit);

    final totalProfitPerHour = context.select<HomeViewModel, double>(
        (viewModel) => viewModel.totalProfitPerHour);

    return Table(
      border: TableBorder.all(color: Colors.white),
      children: [
        TableRow(children: [
          const Text("Total Revenue"),
          Text(viewModel.formatInteger(totalRevenue.toString())),
        ]),
        TableRow(children: [
          const Text("Total Expenses"),
          Text(viewModel.formatInteger(totalExpense.toString())),
        ]),
        TableRow(children: [
          const Text("Total Profit"),
          Text(viewModel.formatInteger(totalProfit.toString())),
        ]),
        TableRow(children: [
          const Text("Total Profit Per Hour"),
          Text(viewModel.formatDouble(totalProfitPerHour.toString())),
        ]),
      ],
    );
  }
}

class ItemBox extends StatelessWidget {
  final String itemName;
  final int? itemCount;

  //used for displaying items without a count like chests
  const ItemBox({super.key, required this.itemName}) : itemCount = null;

  //used for displaying items that have count of them like chest drops
  ItemBox.fromMapEntry({super.key, required MapEntry<String, Item> mapEntry})
      : itemName = mapEntry.key,
        itemCount = mapEntry.value.quantity;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeViewModel>();
    final Size screenSizes = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xff2C2E45),
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(
                  itemCount != null ? screenSizes.height * 0.02 : 0),
              child: SvgPicture.asset(
                  "assets/svgs/${viewModel.formatForAssets(itemName)}.svg"),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                (itemCount != null ? itemCount! : "").toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChestChoosingDialog extends StatelessWidget {
  const ChestChoosingDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.read<HomeViewModel>();
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: AlertDialog(
          shadowColor: Theme.of(context).colorScheme.onSurface,
          title: const Text(
            "Choose chest",
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 10,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: GestureDetector(
                      onTap: () {
                        homeViewModel.changeCurrentChest("Chimerical Chest");
                        Navigator.of(context).pop();
                      },
                      child: const ItemBox(itemName: "Chimerical Chest"),
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 10,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: GestureDetector(
                      onTap: () {
                        homeViewModel.changeCurrentChest("Sinister Chest");
                        Navigator.of(context).pop();
                      },
                      child: const ItemBox(itemName: "Sinister Chest"),
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 10,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: GestureDetector(
                      onTap: () {
                        homeViewModel.changeCurrentChest("Enchanted Chest");
                        Navigator.of(context).pop();
                      },
                      child: const ItemBox(itemName: "Enchanted Chest"),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ChestCountTextField extends StatelessWidget {
  const ChestCountTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textFieldController =
        context.read<HomeViewModel>().chestQuantityEditingController;
    return TextField(
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      controller: textFieldController,
      decoration: const InputDecoration(border: OutlineInputBorder()),
    );
  }
}
