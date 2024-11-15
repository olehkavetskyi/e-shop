document.addEventListener("DOMContentLoaded", () => {
    // Image Preview Logic
    const imageInput = document.getElementById("product_image");
    const previewImage = document.getElementById("imagePreview");

    if (imageInput && previewImage) {
        imageInput.addEventListener("change", (event) => {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = (e) => {
                    previewImage.src = e.target.result;
                    previewImage.style.display = "block";
                };
                reader.readAsDataURL(file);
            } else {
                previewImage.src = "#";
                previewImage.style.display = "none";
            }
        });
    }

    // Category Suggestions Logic
    const categoryInput = document.getElementById("category_name");
    const suggestionList = document.getElementById("category_suggestions");

    categoryInput.addEventListener("input", () => {
        const query = categoryInput.value;

        if (query.length >= 2) {
            fetch(`/categories/search?query=${query}`)
                .then((response) => response.json())
                .then((data) => {
                    suggestionList.innerHTML = "";
                    data.categories.forEach((category) => {
                        const listItem = document.createElement("li");
                        listItem.textContent = category.name;
                        listItem.setAttribute("data-category-id", category.id);
                        listItem.classList.add("suggestion-item");
                        suggestionList.appendChild(listItem);
                    });
                });
        } else {
            suggestionList.innerHTML = "";
        }
    });

    suggestionList.addEventListener("click", (event) => {
        if (event.target && event.target.classList.contains("suggestion-item")) {
            categoryInput.value = event.target.textContent;
            document.getElementById("product_category_id").value = event.target.getAttribute("data-category-id");
            suggestionList.innerHTML = "";
        }
    });
});
