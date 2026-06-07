<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard — D2 Caferaria</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="admin.css">
</head>
<body>

<div class="app">

  <!-- SIDEBAR -->
  <aside class="sidebar" id="sidebar">
    <div class="sidebar-brand">
      <span class="brand-icon">D2</span>
      <div>
        <strong>D2 Caferaria</strong>
        <small>Admin Panel</small>
      </div>
    </div>

    <nav>
      <a class="active" onclick="UI.page('dashboard')" data-page="dashboard">
        <span class="nav-icon">&#9632;</span> Dashboard
      </a>
      <a onclick="UI.page('category')" data-page="category">
        <span class="nav-icon">&#9632;</span> Category
      </a>
      <a onclick="UI.page('menu')" data-page="menu">
        <span class="nav-icon">&#9632;</span> Menu
      </a>
      <a onclick="UI.page('admins')" data-page="admins">
        <span class="nav-icon">&#9632;</span> Admins
      </a>
      <a class="logout-link" onclick="logout()">
        <span class="nav-icon">&#9632;</span> Logout
      </a>
    </nav>
  </aside>

  <div class="main">

    <!-- TOPBAR -->
    <header class="topbar">
      <div class="topbar-left">
        <button class="menu-toggle" onclick="toggleSidebar()">&#9776;</button>
        <h3 id="pageTitle">Dashboard</h3>
      </div>
      <div class="topbar-right">
        <span class="admin-badge"><span id="adminName">Admin</span></span>
      </div>
    </header>

    <!-- ═══════════════════════════════════════ -->
    <!-- DASHBOARD PAGE                          -->
    <!-- ═══════════════════════════════════════ -->
    <section id="dashboard" class="page active">
      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-icon-text">Menu</div>
          <div>
            <div class="stat-label">Total Menu</div>
            <div class="stat-value" id="statMenu">—</div>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-icon-text">Cat</div>
          <div>
            <div class="stat-label">Categories</div>
            <div class="stat-value" id="statCategory">—</div>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-icon-text">Adm</div>
          <div>
            <div class="stat-label">Admins</div>
            <div class="stat-value" id="statAdmin">—</div>
          </div>
        </div>
      </div>

      <div class="card">
        <h3>Recent Menu Items</h3>
        <div id="dashMenuList" class="dash-list"></div>
      </div>
    </section>

    <!-- ═══════════════════════════════════════ -->
    <!-- CATEGORY PAGE                           -->
    <!-- ═══════════════════════════════════════ -->
    <section id="category" class="page">
      <div class="page-header">
        <h2>Categories</h2>
        <button class="btn-primary" onclick="CatUI.openModal()">+ Add Category</button>
      </div>
      <div id="categoryGrid" class="cat-list"></div>
    </section>

    <!-- ═══════════════════════════════════════ -->
    <!-- MENU PAGE                               -->
    <!-- ═══════════════════════════════════════ -->
    <section id="menu" class="page">
      <div class="page-header">
        <h2>Menu Items</h2>
        <div class="page-header-right">
          <input id="menuSearch" placeholder="Search name, category..." oninput="MenuUI.search(this.value)">
          <select id="menuCatFilter" onchange="MenuUI.filterCat(this.value)">
            <option value="">All Categories</option>
          </select>
          <button class="btn-primary" onclick="MenuUI.openModal()">+ Add Menu</button>
        </div>
      </div>
      <div id="menuGrid"></div>
    </section>

    <!-- ═══════════════════════════════════════ -->
    <!-- ADMINS PAGE                             -->
    <!-- ═══════════════════════════════════════ -->
    <section id="admins" class="page">
      <div class="page-header">
        <h2>Admin Users</h2>
        <button class="btn-primary" onclick="AdminUI.openModal()">+ Add Admin</button>
      </div>
      <div class="card table-card">
        <table>
          <thead>
            <tr><th>#</th><th>Username</th><th>Created</th><th>Actions</th></tr>
          </thead>
          <tbody id="adminsTable"></tbody>
        </table>
      </div>
    </section>

  </div><!-- /main -->
</div><!-- /app -->

<!-- ═══════════════════════════════════════════ -->
<!-- MODALS                                      -->
<!-- ═══════════════════════════════════════════ -->

<!-- Category Modal -->
<div id="catModal" class="modal-overlay hidden">
  <div class="modal">
    <div class="modal-header">
      <h3 id="catModalTitle">Add Category</h3>
      <button class="modal-close" onclick="CatUI.closeModal()">&#10005;</button>
    </div>
    <div class="modal-body">
      <input type="hidden" id="catID">
      <div class="field">
        <label>Category Name *</label>
        <input type="text" id="catName" placeholder="e.g. Makanan, Minuman...">
      </div>
      <div class="field">
        <label>Category Image</label>
        <div class="img-upload-area" id="catImgArea" onclick="document.getElementById('catImgInput').click()">
          <img id="catImgPreview" class="hidden" alt="preview">
          <div id="catImgPlaceholder">
            <span class="upload-icon">&#128247;</span>
            <p>Click to upload image</p>
            <small>JPG, PNG, WEBP (max 5MB)</small>
          </div>
        </div>
        <input type="file" id="catImgInput" accept="image/*" class="hidden" onchange="previewImage('catImgInput','catImgPreview','catImgPlaceholder')">
      </div>
    </div>
    <div class="modal-footer">
      <button class="btn-secondary" onclick="CatUI.closeModal()">Cancel</button>
      <button class="btn-primary" onclick="CatUI.save()">Save</button>
    </div>
  </div>
</div>

<!-- Menu Modal -->
<div id="menuModal" class="modal-overlay hidden">
  <div class="modal">
    <div class="modal-header">
      <h3 id="menuModalTitle">Add Menu Item</h3>
      <button class="modal-close" onclick="MenuUI.closeModal()">&#10005;</button>
    </div>
    <div class="modal-body">
      <input type="hidden" id="menuID">
      <div class="field">
        <label>Menu Name *</label>
        <input type="text" id="menuName" placeholder="e.g. Nasi Goreng">
      </div>
      <div class="field">
        <label>Price (Rp) *</label>
        <input type="number" id="menuPrice" placeholder="e.g. 28000">
      </div>
      <div class="field">
        <label>Category</label>
        <select id="menuCatID">
          <option value="">— Select category —</option>
        </select>
      </div>
      <div class="field">
        <label>Short Description</label>
        <textarea id="menuDesc" rows="3" placeholder="Brief description..."></textarea>
      </div>
    </div>
    <div class="modal-footer">
      <button class="btn-secondary" onclick="MenuUI.closeModal()">Cancel</button>
      <button class="btn-primary" onclick="MenuUI.save()">Save</button>
    </div>
  </div>
</div>

<!-- Admin Modal -->
<div id="adminModal" class="modal-overlay hidden">
  <div class="modal">
    <div class="modal-header">
      <h3 id="adminModalTitle">Add Admin</h3>
      <button class="modal-close" onclick="AdminUI.closeModal()">&#10005;</button>
    </div>
    <div class="modal-body">
      <input type="hidden" id="adminEditID">
      <div class="field">
        <label>Username *</label>
        <input type="text" id="adminUsername" placeholder="Enter username">
      </div>
      <div class="field">
        <label id="passLabel">Password *</label>
        <input type="password" id="adminPassword" placeholder="Enter password">
        <small id="passHint" class="hidden field-hint">Leave blank to keep current password</small>
      </div>
    </div>
    <div class="modal-footer">
      <button class="btn-secondary" onclick="AdminUI.closeModal()">Cancel</button>
      <button class="btn-primary" onclick="AdminUI.save()">Save</button>
    </div>
  </div>
</div>

<!-- Confirm Delete Modal -->
<div id="deleteModal" class="modal-overlay hidden">
  <div class="modal modal-sm">
    <div class="modal-header">
      <h3>Confirm Delete</h3>
    </div>
    <div class="modal-body">
      <p id="deleteMsg">Are you sure you want to delete this item?</p>
    </div>
    <div class="modal-footer">
      <button class="btn-secondary" onclick="closeDeleteModal()">Cancel</button>
      <button class="btn-danger" id="deleteConfirmBtn">Delete</button>
    </div>
  </div>
</div>

<!-- Toast -->
<div id="toast" class="toast"></div>

<script src="admin.js"></script>
</body>
</html>