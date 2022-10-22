import 'package:flutter/material.dart';
import 'package:lunch_app/views/prototype/food_detail_view.dart';

class FoodLister extends StatefulWidget {
  @override
  _FoodListerState createState() => _FoodListerState();
}

class _FoodListerState extends State<FoodLister> {
  final PageController controller =
      PageController(initialPage: 2, viewportFraction: 0.9);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.8,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        controller: controller,
        itemBuilder: (c, i) {
          return _ItemWidget();
        },
      ),
    );
  }
}

class _ItemWidget extends StatefulWidget {
  @override
  __ItemWidgetState createState() => __ItemWidgetState();
}

class __ItemWidgetState extends State<_ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => FoodDetailView()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Stack(
          children: [
            _buildBackgroundCard(),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: _buildImage(),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: _buildDetails(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundCard() {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.8 * 0.2,
        ),
        Expanded(
          child: Container(
            // margin: const EdgeInsets.only(top: 40.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    return Center(
      child: Image.asset(
        "assets/images/burger.png",
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildDetails() {
    return Column(
      children: [
        Text(
          "Hello Burger",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Expanded(
          child: Center(
            child: Text(
              "An 100% beef party whipped in a soft bean and topped with onion, cheese and tomato",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "\$3.58",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "\$5.58",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
