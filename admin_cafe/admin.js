// ================================================
// D2 CAFERARIA — Admin Dashboard JS
// ================================================

const API = {
  base: 'api/',
  async get(endpoint) {
    const r = await fetch(this.base + endpoint, { credentials: 'include' });
    if (!r.ok) throw await r.json();
    return r.json();
  },
  async post(endpoint, formData) {
    const r = await fetch(this.base + endpoint, { method: 'POST', credentials: 'include', body: formData });
    const d = await r.json();
    if (!r.ok) throw d;
    return d;
  },
  async put(endpoint, formData) {
    // PHP doesn't parse multipart PUT natively — tunnel via POST with ?_method=PUT
    const sep = endpoint.includes('?') ? '&' : '?';
    const r = await fetch(this.base + endpoint + sep + '_method=PUT', {
      method: 'POST',
      credentials: 'include',
      body: formData
    });
    const d = await r.json();
    if (!r.ok) throw d;
    return d;
  },
  async delete(endpoint) {
    // Tunnel DELETE via POST with ?_method=DELETE so PHP session cookie is sent
    const sep = endpoint.includes('?') ? '&' : '?';
    const r = await fetch(this.base + endpoint + sep + '_method=DELETE', {
      method: 'POST',
      credentials: 'include'
    });
    const d = await r.json();
    if (!r.ok) throw d;
    return d;
  },
  async json(endpoint, method, body) {
    // Tunnel PUT/DELETE as POST with ?_method= so PHP session cookie is always sent
    let url = this.base + endpoint;
    let httpMethod = method;
    if (method === 'PUT' || method === 'DELETE') {
      const sep = url.includes('?') ? '&' : '?';
      url += sep + '_method=' + method;
      httpMethod = 'POST';
    }
    const r = await fetch(url, {
      method: httpMethod,
      credentials: 'include',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(body)
    });
    const d = await r.json();
    if (!r.ok) throw d;
    return d;
  }
};

// ── STATE ────────────────────────────────────────
const State = {
  categories: [],
  menus: [],
  admins: [],
};

// ── TOAST ────────────────────────────────────────
function toast(msg, type = 'info') {
  const el = document.getElementById('toast');
  el.textContent = msg;
  el.className = `toast ${type} show`;
  clearTimeout(el._t);
  el._t = setTimeout(() => el.classList.remove('show'), 3000);
}

// ── SIDEBAR / PAGE NAV ───────────────────────────
const UI = {
  page(id) {
    document.querySelectorAll('.page').forEach(p => p.classList.remove('active'));
    document.getElementById(id).classList.add('active');

    document.querySelectorAll('.sidebar nav a[data-page]').forEach(a => a.classList.remove('active'));
    const link = document.querySelector(`.sidebar nav a[data-page="${id}"]`);
    if (link) link.classList.add('active');

    const titles = { dashboard: 'Dashboard', category: 'Categories', menu: 'Menu', admins: 'Admin Users' };
    document.getElementById('pageTitle').textContent = titles[id] || id;

    if (id === 'dashboard') Dashboard.load();
    if (id === 'category')  CatUI.load();
    if (id === 'menu')      MenuUI.load();
    if (id === 'admins')    AdminUI.load();

    // close sidebar on mobile
    if (window.innerWidth <= 768) document.getElementById('sidebar').classList.remove('open');
  }
};

function toggleSidebar() {
  document.getElementById('sidebar').classList.toggle('open');
}

// ── IMAGE PREVIEW ────────────────────────────────
function previewImage(inputId, previewId, placeholderId) {
  const file = document.getElementById(inputId).files[0];
  if (!file) return;
  const preview = document.getElementById(previewId);
  const placeholder = document.getElementById(placeholderId);
  const reader = new FileReader();
  reader.onload = e => {
    preview.src = e.target.result;
    preview.classList.remove('hidden');
    placeholder.classList.add('hidden');
  };
  reader.readAsDataURL(file);
}

// ── CONFIRM DELETE MODAL ─────────────────────────
let _deleteCallback = null;

function confirmDelete(message, callback) {
  document.getElementById('deleteMsg').textContent = message;
  _deleteCallback = callback;
  document.getElementById('deleteModal').classList.remove('hidden');
  document.getElementById('deleteConfirmBtn').onclick = async () => {
    closeDeleteModal();
    await callback();
  };
}

function closeDeleteModal() {
  document.getElementById('deleteModal').classList.add('hidden');
  _deleteCallback = null;
}

// ── FORMAT PRICE ─────────────────────────────────
function formatPrice(p) {
  return 'Rp ' + Number(p).toLocaleString('id-ID');
}

// ── IMAGE SRC ─────────────────────────────────────
function imgSrc(path) {
  if (!path) return null;
  // Already a full URL (new uploads store http://localhost/cafe/Images/...)
  if (path.startsWith('http') || path.startsWith('/')) return path;
  // Legacy DB records store relative path like "Images/ricebowl.png"
  // These files physically live in C:/laragon/www/cafe/Images/
  return 'http://localhost/cafe/' + path;
}

// ═══════════════════════════════════════════════════
// DASHBOARD
// ═══════════════════════════════════════════════════
const Dashboard = {
  async load() {
    document.getElementById('statMenu').textContent     = '…';
    document.getElementById('statCategory').textContent = '…';
    document.getElementById('statAdmin').textContent    = '…';
    try {
      const [menus, cats, admins] = await Promise.all([
        API.get('menu.php'),
        API.get('category.php'),
        API.get('admin_users.php'),
      ]);

      State.menus      = menus;
      State.categories = cats;
      State.admins     = admins;

      document.getElementById('statMenu').textContent     = menus.length;
      document.getElementById('statCategory').textContent = cats.length;
      document.getElementById('statAdmin').textContent    = admins.length;

      // Recent 5 menu items
      const list = document.getElementById('dashMenuList');
      const recent = menus.slice(-5).reverse();
      if (!recent.length) {
        list.innerHTML = '<p style="color:var(--muted);font-size:13px">No menu items yet.</p>';
        return;
      }
      list.innerHTML = recent.map(m => `
        <div class="dash-menu-item">
          <div class="dish-emoji">🍽️</div>
          <div class="item-info">
            <div class="item-name">${m.MenuName}</div>
            <div class="item-cat">${m.CategoryName || 'Uncategorized'}</div>
          </div>
          <div class="item-price">${formatPrice(m.Price)}</div>
        </div>`).join('');
    } catch(e) {
      console.error('Dashboard load error:', e);
      document.getElementById('statMenu').textContent     = '0';
      document.getElementById('statCategory').textContent = '0';
      document.getElementById('statAdmin').textContent    = '0';
      document.getElementById('dashMenuList').innerHTML =
        '<p style="color:var(--muted);font-size:13px">Failed to load data. Check API connection.</p>';
      toast('Failed to load dashboard data', 'error');
    }
  }
};

// ═══════════════════════════════════════════════════
// CATEGORY
// ═══════════════════════════════════════════════════
const CatUI = {
  async load() {
    const grid = document.getElementById('categoryGrid');
    grid.innerHTML = `<div class="skeleton" style="height:160px;border-radius:12px"></div>`.repeat(4);
    try {
      const cats = await API.get('category.php');
      State.categories = cats;
      this.render(cats);
    } catch(e) {
      toast('Failed to load categories', 'error');
    }
  },

  render(cats) {
    const grid = document.getElementById('categoryGrid');
    if (!cats.length) {
      grid.innerHTML = `<div class="empty-state"><span>🏷️</span>No categories yet. Add one!</div>`;
      return;
    }
    grid.innerHTML = cats.map(c => `
      <div class="cat-card">
        <div class="cat-card-img">
          ${c.ImagePath
            ? `<img src="${imgSrc(c.ImagePath)}" alt="${c.CategoryName}">`
            : '🏷️'}
        </div>
        <div class="cat-card-body">
          <div class="cat-card-name">${c.CategoryName}</div>
          <div class="cat-card-meta">Added by ${c.AddedBy || 'system'}</div>
          <div class="cat-card-actions">
            <button class="btn-primary btn-sm" onclick="CatUI.openModal('${c.CategoryID}')">✏️ Edit</button>
            <button class="btn-danger btn-sm" onclick="CatUI.confirmDelete('${c.CategoryID}','${escHtml(c.CategoryName)}')">🗑️</button>
          </div>
        </div>
      </div>`).join('');
  },

  openModal(id) {
    resetImgPreview('catImgPreview', 'catImgPlaceholder', 'catImgInput');
    document.getElementById('catID').value   = '';
    document.getElementById('catName').value = '';
    document.getElementById('catModalTitle').textContent = 'Add Category';

    if (id) {
      const cat = State.categories.find(c => c.CategoryID == id);
      if (!cat) { toast('Category not found — please reload the page', 'error'); return; }
      document.getElementById('catModalTitle').textContent = 'Edit Category';
      document.getElementById('catID').value   = cat.CategoryID;
      document.getElementById('catName').value = cat.CategoryName;
      if (cat.ImagePath) {
        const preview = document.getElementById('catImgPreview');
        preview.src = imgSrc(cat.ImagePath);
        preview.classList.remove('hidden');
        document.getElementById('catImgPlaceholder').classList.add('hidden');
      }
    }
    document.getElementById('catModal').classList.remove('hidden');
  },

  closeModal() { document.getElementById('catModal').classList.add('hidden'); },

  async save() {
    const id   = document.getElementById('catID').value;
    const name = document.getElementById('catName').value.trim();
    if (!name) { toast('Category name is required', 'error'); return; }

    const fd = new FormData();
    fd.append('CategoryName', name);
    const imgFile = document.getElementById('catImgInput').files[0];
    if (imgFile) fd.append('image', imgFile);

    try {
      if (id) {
        await API.put(`category.php?id=${id}`, fd);
        toast('Category updated ✓', 'success');
      } else {
        await API.post('category.php', fd);
        toast('Category added ✓', 'success');
      }
      this.closeModal();
      this.load();
    } catch(e) {
      toast(e.error || JSON.stringify(e) || 'Save failed', 'error');
    }
  },

  confirmDelete(id, name) {
    confirmDelete(`Please delete all menus in "${name}" before deleting this category. Are you sure you want to proceed?`, async () => {
      try {
        await API.delete(`category.php?id=${id}`);
        toast('Category deleted', 'info');
        this.load();
      } catch(e) { toast(e.error || JSON.stringify(e) || 'Delete failed', 'error'); }
    });
  }
};

// ═══════════════════════════════════════════════════
// MENU
// ═══════════════════════════════════════════════════
const MenuUI = {
  _all: [],

  async load() {
    const grid = document.getElementById('menuGrid');
    grid.innerHTML = `<div class="skeleton" style="height:240px;border-radius:12px"></div>`.repeat(4);
    try {
      const [menus, cats] = await Promise.all([
        API.get('menu.php'),
        API.get('category.php')
      ]);
      State.menus      = menus;
      State.categories = cats;
      this._all        = menus;
      this.render(menus);
      this.populateCatSelect();
    } catch(e) {
      toast('Failed to load menus', 'error');
    }
  },

  populateCatSelect() {
    const sel = document.getElementById('menuCatID');
    sel.innerHTML = '<option value="">— Select category —</option>';
    State.categories.forEach(c => {
      sel.innerHTML += `<option value="${c.CategoryID}">${c.CategoryName}</option>`;
    });
  },

  render(menus) {
    const grid = document.getElementById('menuGrid');
    if (!menus.length) {
      grid.innerHTML = `<div class="empty-state"><span>🍽️</span>No menu items yet. Add one!</div>`;
      return;
    }
    grid.innerHTML = menus.map(m => `
      <div class="menu-card">
        <div class="menu-card-body">
          ${m.CategoryName ? `<div class="menu-card-badge">${m.CategoryName}</div>` : ''}
          <div class="menu-card-name">${m.MenuName}</div>
          <div class="menu-card-price">${formatPrice(m.Price)}</div>
          <div class="menu-card-desc">${m.ShortDesc || '<em style="color:var(--muted)">No description</em>'}</div>
          <div class="menu-card-actions">
            <button class="btn-primary btn-sm" onclick="MenuUI.openModal('${m.MenuID}')">✏️ Edit</button>
            <button class="btn-danger btn-sm" onclick="MenuUI.confirmDelete('${m.MenuID}','${escHtml(m.MenuName)}')">🗑️</button>
          </div>
        </div>
      </div>`).join('');
  },

  search(q) {
    const f = this._all.filter(m => m.MenuName.toLowerCase().includes(q.toLowerCase()));
    this.render(f);
  },

  openModal(id) {
    document.getElementById('menuID').value    = '';
    document.getElementById('menuName').value  = '';
    document.getElementById('menuPrice').value = '';
    document.getElementById('menuDesc').value  = '';
    document.getElementById('menuCatID').value = '';
    document.getElementById('menuModalTitle').textContent = 'Add Menu Item';
    this.populateCatSelect();

    if (id) {
      const m = State.menus.find(x => x.MenuID == id);
      if (!m) { toast('Menu item not found — please reload the page', 'error'); return; }
      document.getElementById('menuModalTitle').textContent = 'Edit Menu Item';
      document.getElementById('menuID').value    = m.MenuID;
      document.getElementById('menuName').value  = m.MenuName;
      document.getElementById('menuPrice').value = m.Price;
      document.getElementById('menuDesc').value  = m.ShortDesc || '';
      document.getElementById('menuCatID').value = m.CategoryID || '';
    }
    document.getElementById('menuModal').classList.remove('hidden');
  },

  closeModal() { document.getElementById('menuModal').classList.add('hidden'); },

  async save() {
    const id    = document.getElementById('menuID').value;
    const name  = document.getElementById('menuName').value.trim();
    const price = document.getElementById('menuPrice').value.trim();
    const catID = document.getElementById('menuCatID').value;
    const desc  = document.getElementById('menuDesc').value.trim();

    if (!name || !price) { toast('Menu name and price are required', 'error'); return; }

    const fd = new FormData();
    fd.append('MenuName',  name);
    fd.append('Price',     price);
    fd.append('CatID',     catID);
    fd.append('ShortDesc', desc);

    try {
      if (id) {
        await API.put(`menu.php?id=${id}`, fd);
        toast('Menu updated ✓', 'success');
      } else {
        await API.post('menu.php', fd);
        toast('Menu added ✓', 'success');
      }
      this.closeModal();
      this.load();
    } catch(e) {
      toast(e.error || 'Save failed', 'error');
    }
  },

  confirmDelete(id, name) {
    confirmDelete(`Delete menu item "${name}"?`, async () => {
      try {
        await API.delete(`menu.php?id=${id}`);
        toast('Menu item deleted', 'info');
        this.load();
      } catch(e) { toast(e.error || JSON.stringify(e) || 'Delete failed', 'error'); }
    });
  }
};

// ═══════════════════════════════════════════════════
// ADMIN USERS
// ═══════════════════════════════════════════════════
const AdminUI = {
  async load() {
    try {
      const admins = await API.get('admin_users.php');
      State.admins = admins;
      this.render(admins);
    } catch(e) {
      toast('Failed to load admins', 'error');
    }
  },

  render(admins) {
    const tbody = document.getElementById('adminsTable');
    if (!admins.length) {
      tbody.innerHTML = `<tr><td colspan="4" style="text-align:center;color:var(--muted);padding:30px">No admins found.</td></tr>`;
      return;
    }
    tbody.innerHTML = admins.map(a => `
      <tr>
        <td>${a.AdminID}</td>
        <td><strong>${a.Username}</strong></td>
        <td>${new Date(a.CreatedAt).toLocaleDateString('id-ID')}</td>
        <td>
          <button class="btn-primary btn-sm" onclick="AdminUI.openModal('${a.AdminID}')">✏️ Edit</button>
          <button class="btn-danger btn-sm" onclick="AdminUI.confirmDelete('${a.AdminID}','${escHtml(a.Username)}')">🗑️</button>
        </td>
      </tr>`).join('');
  },

  openModal(id) {
    document.getElementById('adminEditID').value  = '';
    document.getElementById('adminUsername').value = '';
    document.getElementById('adminPassword').value = '';
    document.getElementById('adminModalTitle').textContent = 'Add Admin';
    document.getElementById('passLabel').textContent = 'Password *';
    document.getElementById('passHint').classList.add('hidden');

    if (id) {
      const a = State.admins.find(x => x.AdminID == id);
      if (!a) return;
      document.getElementById('adminModalTitle').textContent = 'Edit Admin';
      document.getElementById('adminEditID').value   = a.AdminID;
      document.getElementById('adminUsername').value = a.Username;
      document.getElementById('passLabel').textContent = 'New Password';
      document.getElementById('passHint').classList.remove('hidden');
    }
    document.getElementById('adminModal').classList.remove('hidden');
  },

  closeModal() { document.getElementById('adminModal').classList.add('hidden'); },

  async save() {
    const id       = document.getElementById('adminEditID').value;
    const username = document.getElementById('adminUsername').value.trim();
    const password = document.getElementById('adminPassword').value.trim();

    if (!username) { toast('Username is required', 'error'); return; }
    if (!id && !password) { toast('Password is required for new admin', 'error'); return; }

    try {
      if (id) {
        await API.json(`admin_users.php?id=${id}`, 'PUT', { username, password });
        toast('Admin updated ✓', 'success');
      } else {
        await API.json('admin_users.php', 'POST', { username, password });
        toast('Admin added ✓', 'success');
      }
      this.closeModal();
      this.load();
    } catch(e) {
      toast(e.error || 'Save failed', 'error');
    }
  },

  confirmDelete(id, name) {
    confirmDelete(`Delete admin "${name}"?`, async () => {
      try {
        await API.delete(`admin_users.php?id=${id}`);
        toast('Admin deleted', 'info');
        this.load();
      } catch(e) { toast(e.error || e.error || 'Delete failed', 'error'); }
    });
  }
};

// ── HELPERS ──────────────────────────────────────
function escHtml(str) {
  return String(str)
    .replace(/&/g, '&amp;')
    .replace(/'/g, '&#39;')
    .replace(/"/g, '&quot;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;');
}

function resetImgPreview(previewId, placeholderId, inputId) {
  const preview     = document.getElementById(previewId);
  const placeholder = document.getElementById(placeholderId);
  preview.src = '';
  preview.classList.add('hidden');
  placeholder.classList.remove('hidden');
  document.getElementById(inputId).value = '';
}

// ── LOGOUT ───────────────────────────────────────
async function logout() {
  try { await API.get('auth.php?action=logout'); } catch(e) {}
  sessionStorage.clear();
  document.body.style.opacity = '0';
  document.body.style.transition = '0.3s';
  setTimeout(() => window.location.href = 'login.php', 300);
}

// ── AUTH CHECK + INIT ─────────────────────────────
(async () => {
  try {
    const check = await API.get('auth.php?action=check');
    if (!check.loggedIn) {
      window.location.href = 'login.php';
      return;
    }
    document.getElementById('adminName').textContent = check.username;
    Dashboard.load();
  } catch(e) {
    // If PHP not available, fall back to session storage check (dev mode)
    const user = sessionStorage.getItem('adminUser');
    if (!user) {
      window.location.href = 'login.php';
      return;
    }
    document.getElementById('adminName').textContent = user;
    // Show a notice that backend is needed
    toast('⚠️ Running without PHP backend — connect to MySQL for full functionality', 'error');
  }
})();