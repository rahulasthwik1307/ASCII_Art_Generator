

# 🎨 ASCII Art Generator

![ASCII Art Example](https://github.com/rahulasthwik1307/ASCII_Art_Generator/blob/10e86b10d18021fcf061229b07008c8da8589488/1st.png)

<!-- Replace with your actual screenshot -->

A **Ruby** application that converts text into ASCII art with a graphical interface and real-time browser preview.

---

## 🚀 Features

* 🎨 Multiple ASCII art **font styles**
* 🖥️ Dual interface: **GUI input** + **browser output**
* 📋 **Copy to clipboard** functionality
* ⚡ **Real-time generation**
* 🎚️ **Font cycling** with keyboard shortcuts

---

## 📦 Prerequisites

* ✅ Ruby **3.0+**
* ✅ `bundler` gem
* ✅ Git

---

## 🔧 Installation

1. **Clone the repository**:

   ```bash
   git clone https://github.com/rahulasthwik1307/ASCII_Art_Generator.git
   cd ASCII_Art_Generator
   ```

2. **Install dependencies**:

   ```bash
   bundle install
   ```

---

## ▶️ How to Use

### 🟢 Step 1: Launch the Server

![Server Launch](https://github.com/rahulasthwik1307/ASCII_Art_Generator/blob/02ced29734bbbe8a5506af38cf01e377ea8027ff/screenshots/server.png)

```bash
ruby app/server.rb
```

---

### 🟢 Step 2: Run the Client Application

![Client Window](https://github.com/rahulasthwik1307/ASCII_Art_Generator/blob/faa445d935759c692c955556af1e0547cbdb9c2d/screenshots/client.png)

![image alt](https://github.com/rahulasthwik1307/ASCII_Art_Generator/blob/faa445d935759c692c955556af1e0547cbdb9c2d/screenshots/window.png)

```bash
ruby app/main.rb
```

---

### 🟢 Step 3: Generate ASCII Art

1. Type your text in the application window
2. Change fonts using:

   * ▲ / ▼ keys to cycle through fonts
   * Press **`F`** for a random font
3. Press **Enter** to generate art

---

### 🟢 Step 4: View in Browser

![Browser Output](https://github.com/rahulasthwik1307/ASCII_Art_Generator/blob/c6bc609dba0dbcac9a7644c234da308a831cd177/screenshots/5th.png)
Open your browser and go to:
➡️ [http://localhost:4567](http://localhost:4567)

---

## ⌨️ Keyboard Controls

| Key       | Action                       |
| --------- | ---------------------------- |
| Typing    | Enter text                   |
| Backspace | Delete character             |
| ▲ / ▼     | Cycle through fonts          |
| `F`       | Select a random font         |
| `Enter`   | Generate and view in browser |

---

## 📁 Project Structure

```
ASCII_Art_Generator/
├── app/
│   ├── main.rb         # GUI client
│   └── server.rb       # Web server
├── fonts/
│   └── OpenSans-Regular.ttf
├── public/
│   └── styles.css      # Styles for browser view
├── views/
│   └── index.erb       # Browser output template
├── Gemfile
└── README.md
```

---

## 🛠️ Troubleshooting

❌ **Server not starting**

* Ensure port **4567** is free
* Run `bundle check` to verify dependencies

❌ **Fonts not loading**

* Confirm the font file exists in the `fonts/` folder

❌ **Browser not updating**

* Refresh the browser
* Check the terminal for errors

---

## 📸 Screenshot Guide

1. **Application Window**
   ![App Window](https://github.com/rahulasthwik1307/ASCII_Art_Generator/blob/c6bc609dba0dbcac9a7644c234da308a831cd177/screenshots/window.png) <!-- Replace with your real screenshot -->

2. **Browser Output**
   ![Browser Output](https://github.com/rahulasthwik1307/ASCII_Art_Generator/blob/c6bc609dba0dbcac9a7644c234da308a831cd177/screenshots/5th.png) <!-- Replace with your real screenshot -->

3. **Font Selection Interface**
<p align="center">
  <img src="screenshots/fonts.png" width="45%" />
  <img src="screenshots/fonts1.png" width="45%" />
</p>


