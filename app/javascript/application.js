// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", () => {
  const image = document.getElementById("home-main-image")
  const nextButton = document.getElementById("home-next-button")
  const prevButton = document.getElementById("home-prev-button")

  if (!image || !nextButton || !prevButton) return

  const hero = document.querySelector(".home-hero")
  if (!hero) return
  const images = JSON.parse(hero.dataset.images)

  let currentIndex = 0

  nextButton.addEventListener("click", () => {
    currentIndex = (currentIndex + 1) % images.length
    image.src = images[currentIndex]
  })

  prevButton.addEventListener("click", () => {
    currentIndex = (currentIndex - 1 + images.length) % images.length
    image.src = images[currentIndex]
  })
})

document.addEventListener("turbo:load", () => {
  const trigger = document.getElementById("photo-zoom-trigger");
  const modal = document.getElementById("photo-zoom-modal");
  const close = document.getElementById("photo-zoom-close");
  const zoomImage = modal?.querySelector(".photo-zoom-image");

  if (!trigger || !modal || !close || !zoomImage) return;

  let zoomLevel = 1;

  // 写真の移動量
  let positionX = 0;
  let positionY = 0;

  // ドラッグ状態
  let isDragging = false;

  // ドラッグ開始位置
  let startX = 0;
  let startY = 0;

  // --------------------------------
  // 移動可能な範囲を計算
  // --------------------------------
  function getMaxPosition() {
    const imageWidth = zoomImage.offsetWidth;
    const imageHeight = zoomImage.offsetHeight;

    const scaledWidth = imageWidth * zoomLevel;
    const scaledHeight = imageHeight * zoomLevel;

    const maxX = Math.max(
      0,
      (scaledWidth - modal.clientWidth) / 2
    );

    const maxY = Math.max(
      0,
      (scaledHeight - modal.clientHeight) / 2
    );

    return {
      maxX,
      maxY
    };
  }

  // --------------------------------
  // 移動範囲を超えないように制限
  // --------------------------------
  function clampPosition() {
    const { maxX, maxY } = getMaxPosition();

    positionX = Math.min(Math.max(positionX, -maxX), maxX);
    positionY = Math.min(Math.max(positionY, -maxY), maxY);
  }

  // --------------------------------
  // 写真の位置・倍率を反映
  // --------------------------------
  function updateImageTransform() {
    clampPosition();

    zoomImage.style.transform =
      `translate(${positionX}px, ${positionY}px) scale(${zoomLevel})`;
  }

  // --------------------------------
  // 写真をクリックしてモーダル表示
  // --------------------------------
  trigger.addEventListener("click", () => {
    modal.classList.add("is-open");

    zoomLevel = 1;
    positionX = 0;
    positionY = 0;

    updateImageTransform();
  });

  // --------------------------------
  // マウスホイールでズーム
  // --------------------------------
  zoomImage.addEventListener("wheel", (event) => {
    event.preventDefault();

    if (event.deltaY < 0) {
      // 上 → 拡大
      zoomLevel += 0.2;
    } else {
      // 下 → 縮小
      zoomLevel -= 0.2;
    }

    // 1倍〜4倍
    zoomLevel = Math.min(Math.max(zoomLevel, 1), 4);

    // 1倍なら中央に戻す
    if (zoomLevel === 1) {
      positionX = 0;
      positionY = 0;
    }

    updateImageTransform();
  }, { passive: false });

  // --------------------------------
  // ドラッグ開始
  // --------------------------------
  zoomImage.addEventListener("mousedown", (event) => {
    // 1倍ではドラッグできない
    if (zoomLevel <= 1) return;

    isDragging = true;

    startX = event.clientX - positionX;
    startY = event.clientY - positionY;

    zoomImage.classList.add("is-dragging");

    zoomImage.style.transition = "none";

    event.preventDefault();
  });

  // --------------------------------
  // ドラッグ中
  // --------------------------------
  document.addEventListener("mousemove", (event) => {
    if (!isDragging) return;

    positionX = event.clientX - startX;
    positionY = event.clientY - startY;

    updateImageTransform();
  });

  // --------------------------------
  // ドラッグ終了
  // --------------------------------
  document.addEventListener("mouseup", () => {
    if (!isDragging) return;

    isDragging = false;

    zoomImage.classList.remove("is-dragging");

    zoomImage.style.transition = "transform 0.15s ease";
  });

  // --------------------------------
  // ×ボタン
  // --------------------------------
  close.addEventListener("click", () => {
    modal.classList.remove("is-open");

    zoomLevel = 1;
    positionX = 0;
    positionY = 0;

    updateImageTransform();
  });

  // --------------------------------
  // 黒背景クリック
  // --------------------------------
  modal.addEventListener("click", (event) => {
    if (event.target === modal) {
      modal.classList.remove("is-open");

      zoomLevel = 1;
      positionX = 0;
      positionY = 0;

      updateImageTransform();
    }
  });

  // --------------------------------
  // ウィンドウサイズ変更時
  // --------------------------------
  window.addEventListener("resize", () => {
    if (!modal.classList.contains("is-open")) return;

    clampPosition();
    updateImageTransform();
  });
});

document.addEventListener("turbo:load", () => {

  const triggers = document.querySelectorAll(".challenge-zoom-trigger");
  const modal = document.getElementById("challenge-zoom-modal");
  const close = document.getElementById("challenge-zoom-close");
  const zoomImage = document.getElementById("challenge-zoom-image");

  if (!triggers.length || !modal || !close || !zoomImage) return;

  let zoomLevel = 1;

  let positionX = 0;
  let positionY = 0;

  let isDragging = false;

  let startX = 0;
  let startY = 0;


  // -----------------------------
  // 移動可能範囲
  // -----------------------------
  function getMaxPosition() {

    const imageWidth = zoomImage.offsetWidth;
    const imageHeight = zoomImage.offsetHeight;

    const scaledWidth = imageWidth * zoomLevel;
    const scaledHeight = imageHeight * zoomLevel;

    const maxX = Math.max(
      0,
      (scaledWidth - modal.clientWidth) / 2
    );

    const maxY = Math.max(
      0,
      (scaledHeight - modal.clientHeight) / 2
    );

    return {
      maxX,
      maxY
    };
  }


  // -----------------------------
  // 移動範囲を制限
  // -----------------------------
  function clampPosition() {

    const { maxX, maxY } = getMaxPosition();

    positionX = Math.min(
      Math.max(positionX, -maxX),
      maxX
    );

    positionY = Math.min(
      Math.max(positionY, -maxY),
      maxY
    );
  }


  // -----------------------------
  // 写真の位置・倍率を反映
  // -----------------------------
  function updateImageTransform() {

    clampPosition();

    zoomImage.style.transform =
      `translate(${positionX}px, ${positionY}px) scale(${zoomLevel})`;
  }


  // -----------------------------
  // 写真をクリック
  // -----------------------------
  triggers.forEach((trigger) => {

    trigger.addEventListener("click", () => {

      zoomImage.src = trigger.src;

      modal.classList.add("is-open");

      zoomLevel = 1;

      positionX = 0;
      positionY = 0;

      updateImageTransform();

    });

  });


  // -----------------------------
  // マウスホイールでズーム
  // -----------------------------
  zoomImage.addEventListener("wheel", (event) => {

    event.preventDefault();

    if (event.deltaY < 0) {

      zoomLevel += 0.2;

    } else {

      zoomLevel -= 0.2;

    }

    zoomLevel = Math.min(
      Math.max(zoomLevel, 1),
      4
    );

    if (zoomLevel === 1) {

      positionX = 0;
      positionY = 0;

    }

    updateImageTransform();

  }, { passive: false });


  // -----------------------------
  // ドラッグ開始
  // -----------------------------
  zoomImage.addEventListener("mousedown", (event) => {

    if (zoomLevel <= 1) return;

    isDragging = true;

    startX = event.clientX - positionX;
    startY = event.clientY - positionY;

    zoomImage.classList.add("is-dragging");

    zoomImage.style.transition = "none";

    event.preventDefault();

  });


  // -----------------------------
  // ドラッグ中
  // -----------------------------
  document.addEventListener("mousemove", (event) => {

    if (!isDragging) return;

    positionX = event.clientX - startX;
    positionY = event.clientY - startY;

    updateImageTransform();

  });


  // -----------------------------
  // ドラッグ終了
  // -----------------------------
  document.addEventListener("mouseup", () => {

    if (!isDragging) return;

    isDragging = false;

    zoomImage.classList.remove("is-dragging");

    zoomImage.style.transition =
      "transform 0.15s ease";

  });


  // -----------------------------
  // ×ボタン
  // -----------------------------
  close.addEventListener("click", () => {

    modal.classList.remove("is-open");

    zoomLevel = 1;

    positionX = 0;
    positionY = 0;

    updateImageTransform();

  });


  // -----------------------------
  // 黒背景クリック
  // -----------------------------
  modal.addEventListener("click", (event) => {

    if (event.target === modal) {

      modal.classList.remove("is-open");

      zoomLevel = 1;

      positionX = 0;
      positionY = 0;

      updateImageTransform();

    }

  });


  // -----------------------------
  // ウィンドウサイズ変更
  // -----------------------------
  window.addEventListener("resize", () => {

    if (!modal.classList.contains("is-open")) return;

    clampPosition();

    updateImageTransform();

  });

});


// ------------------------------
// プロフィールタブ
// ------------------------------

const activateProfileTab = (target) => {
  // タブの選択状態を変更
  document.querySelectorAll(".profile-tab").forEach(item => {
    item.classList.remove("active");
  });

  const activeTab = document.querySelector(
    `.profile-tab[data-tab="${target}"]`
  );

  if (activeTab) {
    activeTab.classList.add("active");
  }

  // 表示する一覧を切り替え
  document.querySelectorAll(".profile-tab-content").forEach(content => {
    content.hidden = true;
    content.classList.remove("active");
  });

  const targetContent = document.getElementById(target);

  if (targetContent) {
    targetContent.hidden = false;
    targetContent.classList.add("active");
  }
};

// Turboによる画面遷移後もタブを初期化
document.addEventListener("turbo:load", () => {
  const urlParams = new URLSearchParams(window.location.search);
  const initialTab = urlParams.get("tab") || "photos";

  activateProfileTab(initialTab);
});

// タブクリック時の処理
document.addEventListener("click", (event) => {
  const tab = event.target.closest(".profile-tab");

  if (!tab) return;

  activateProfileTab(tab.dataset.tab);
});

// ------------------------------
// プロフィールのページネーション：スクロール位置を維持
// ------------------------------

const profileScrollKey = "profileScrollPosition";

// ページネーションをクリックしたときに位置を保存
document.addEventListener("click", (event) => {
  const paginationLink = event.target.closest(".profile-page .pagination a");

  if (!paginationLink) return;

  sessionStorage.setItem(profileScrollKey, window.scrollY);
});

// ページ移動後に保存した位置へ戻す
function restoreProfileScroll() {
  const savedPosition = sessionStorage.getItem(profileScrollKey);

  if (savedPosition === null) return;

  sessionStorage.removeItem(profileScrollKey);

  requestAnimationFrame(() => {
    window.scrollTo(0, Number(savedPosition));
  });
}

// 通常のページ読み込み・Turboによるページ遷移に対応
document.addEventListener("DOMContentLoaded", restoreProfileScroll);
document.addEventListener("turbo:load", restoreProfileScroll);

// 使い方画像の拡大表示
document.addEventListener("turbo:load", () => {
  const trigger = document.getElementById("how-to-use-trigger");
  const modal = document.getElementById("how-to-use-modal");
  const close = document.getElementById("how-to-use-close");

  if (!trigger || !modal || !close) return;

  trigger.addEventListener("click", () => {
    modal.classList.add("active");
  });

  close.addEventListener("click", () => {
    modal.classList.remove("active");
  });

  modal.addEventListener("click", (event) => {
    if (event.target === modal) {
      modal.classList.remove("active");
    }
  });
});