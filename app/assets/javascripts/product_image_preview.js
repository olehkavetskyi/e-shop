// app/assets/javascripts/product_image_preview.js
document.addEventListener('DOMContentLoaded', () => {
    const imageInput = document.getElementById('product_image');
    const previewContainer = document.getElementById('image-preview');

    if (imageInput && previewContainer) {
        imageInput.addEventListener('change', (event) => {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = (e) => {
                    previewContainer.innerHTML = `<img src="${e.target.result}" alt="Product Image Preview" class="preview-image" />`;
                };
                reader.readAsDataURL(file);
            }
        });
    }
});
