// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

// flashメッセージが自動的に消える設定
document.addEventListener('turbo:load', () => {
  const flashMessages = document.querySelectorAll('.flash');
  flashMessages.forEach((message) => {
    setTimeout(() => {
      message.style.display = 'none'; // 3秒後に非表示
    }, 3000); // 3000ミリ秒 = 3秒
  });
});
