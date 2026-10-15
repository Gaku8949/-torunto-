// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", () => {
  const image = document.getElementById("home-main-image")
  const nextButton = document.getElementById("home-next-button")
  const prevButton = document.getElementById("home-prev-button")

  if (!image || !nextButton || !prevButton) return

  const images = [
    "/assets/ame.JPG",
    "/assets/blue.JPG",
    "/assets/cosmos.JPG",
    "/assets/forest.png",
    "/assets/hana.JPG"
  ]

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