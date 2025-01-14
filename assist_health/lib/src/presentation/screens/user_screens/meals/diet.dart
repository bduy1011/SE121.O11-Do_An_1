class Diet {
  final String name; // Tên tiếng Anh để map API
  final String description; // Mô tả tiếng Việt

  Diet({required this.name, required this.description});

  static List<Diet> getAllDiets() {
    return [
      Diet(
        name: "Gluten Free",
        description:
            "Tránh gluten nghĩa là loại bỏ lúa mì, lúa mạch, lúa mạch đen và các loại ngũ cốc chứa gluten khác, cùng các thực phẩm làm từ chúng (hoặc có thể bị nhiễm chéo).",
      ),
      Diet(
        name: "Ketogenic",
        description:
            "Chế độ ăn keto dựa trên tỷ lệ chất béo, protein và carbohydrate, thay vì nguyên liệu cụ thể. Thường là 55-80% chất béo, 15-35% protein, và dưới 10% carbohydrate.",
      ),
      Diet(
        name: "Vegetarian",
        description:
            "Không chứa các nguyên liệu từ thịt hoặc các sản phẩm phụ từ thịt như xương hoặc gelatin.",
      ),
      Diet(
        name: "Lacto-Vegetarian",
        description:
            "Tất cả nguyên liệu phải là chay và không được chứa trứng.",
      ),
      Diet(
        name: "Ovo-Vegetarian",
        description: "Tất cả nguyên liệu phải là chay và không được chứa sữa.",
      ),
      Diet(
        name: "Vegan",
        description:
            "Không chứa thịt, các sản phẩm phụ từ thịt như xương hoặc gelatin, cũng như trứng, sữa, hoặc mật ong.",
      ),
      Diet(
        name: "Pescetarian",
        description:
            "Tất cả đều được phép ngoại trừ thịt và các sản phẩm phụ từ thịt. Một số người ăn pescetarian có thể ăn trứng và sữa, số khác thì không.",
      ),
      Diet(
        name: "Paleo",
        description:
            "Nguyên liệu cho phép bao gồm thịt (đặc biệt là từ động vật nuôi cỏ), cá, trứng, rau, một số loại dầu (dầu dừa, dầu olive), một lượng nhỏ trái cây, các loại hạt, và khoai lang. Không cho phép các loại đậu, ngũ cốc, sữa, đường tinh luyện và thực phẩm chế biến.",
      ),
      Diet(
        name: "Primal",
        description:
            "Tương tự Paleo, nhưng cho phép sữa, bao gồm sữa tươi, bơ, ghee, và các sản phẩm từ sữa nguyên kem.",
      ),
      Diet(
        name: "Low FODMAP",
        description:
            "FODMAP là viết tắt của 'fermentable oligo-, di-, mono-saccharides and polyols'. Chế độ ăn này tránh các thực phẩm chứa lượng cao carbohydrate như các loại đậu, lúa mì và sản phẩm từ sữa.",
      ),
      Diet(
        name: "Whole30",
        description:
            "Cho phép: thịt, cá/hải sản, trứng, rau, trái cây tươi, dầu dừa, dầu olive, một lượng nhỏ trái cây sấy khô và các loại hạt/hạt giống. Không cho phép: chất tạo ngọt (tự nhiên hoặc nhân tạo), sữa (trừ bơ làm sạch hoặc ghee), rượu, ngũ cốc, các loại đậu (trừ đậu que, đậu hà lan), và phụ gia thực phẩm như carrageenan, MSG, sulfite.",
      ),
      Diet(
        name: "Dairy Free",
        description:
            "Chế độ ăn không chứa sữa hoặc các sản phẩm từ sữa. Phù hợp cho người bị dị ứng hoặc không dung nạp lactose.",
      ),
      Diet(
        name: "Lacto Ovo Vegetarian",
        description:
            "Không chứa thịt, nhưng cho phép trứng và sữa trong chế độ ăn chay.",
      ),
      Diet(
        name: "Pescatarian",
        description:
            "Chế độ ăn Pescatarian là chế độ ăn chủ yếu dựa trên thực vật nhưng vẫn bao gồm cá và hải sản. Người theo chế độ này không ăn thịt động vật trên cạn (như thịt gà, bò, lợn) nhưng vẫn bổ sung dinh dưỡng từ cá, hải sản, và các sản phẩm từ thực vật như rau củ, ngũ cốc, trái cây, và các loại hạt. Đây là chế độ ăn giàu protein, axit béo omega-3, và phù hợp cho những người muốn giảm tiêu thụ thịt nhưng vẫn nhận được các dưỡng chất từ hải sản.",
      ),
    ];
  }
}
