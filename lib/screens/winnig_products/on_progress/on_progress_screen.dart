import 'package:flutter/material.dart';
import 'package:gobid_admin/base.dart';
import 'package:gobid_admin/model/chat.dart';
import 'package:gobid_admin/screens/winnig_products/on_progress/on_progress_navigator.dart';
import 'package:gobid_admin/screens/winnig_products/on_progress/on_progress_vm.dart';
import 'package:gobid_admin/shared/components/product_card.dart';
import 'package:gobid_admin/shared/constants/app_strings.dart';
import 'package:provider/provider.dart';

class OnProgressScreen extends StatefulWidget {
  const OnProgressScreen({Key? key}) : super(key: key);

  @override
  State<OnProgressScreen> createState() => _OnProgressScreenState();
}

class _OnProgressScreenState
    extends BaseView<OnProgressScreen, OnProgressViewModel>
    implements OnProgressNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  OnProgressViewModel initViewModel() {
    return OnProgressViewModel();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.getOnProgressWinners();
    return ChangeNotifierProvider(
      create: (context)=>viewModel,
      child: Consumer<OnProgressViewModel>(
        builder: (_,onProgressNM,__){
          if(onProgressNM.products==null){
            return Center(child: CircularProgressIndicator());
          }
          if (onProgressNM.products!.isEmpty) {
            return const Center(
              child: Text('No Waiting Delivery Confirmation For today'),
            );
          }
          if (onProgressNM.errorMsg != null) {
            return const Center(
              child: Text(AppStrings.somethingWontWrong),
            );
          }
          return ListView.builder(
            itemCount: onProgressNM.products!.length,
            itemBuilder: (context, index) {
              return Container(
                color: index%2==0?Colors.grey[300]:Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                child: ProductCard(
                  product: onProgressNM.products![index],
                  sellerName: onProgressNM.sellersName[index],
                  winnerName: onProgressNM.winnersName[index],
                  btnTxt: 'Contact',
                  onPressed: () {
                    Chat chat=Chat(
                      id: onProgressNM.products![index].winnerID.last,
                      name: onProgressNM.winnersName[index],
                    );
                  },
                  cancelBtnTxt: 'Remove',
                  cancelBtnPress: (){
                    ///change auction state from onprogrees to confirmed
                    /// وبكدا هيرجع المزاد يتعرض ف الهووم من تاني

                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
