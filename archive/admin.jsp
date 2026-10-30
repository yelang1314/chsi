<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>数据维护管理</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            background: #f2f3f5;
            font-family: -apple-system, BlinkMacSystemFont, "Helvetica Neue", Helvetica, Arial, "PingFang SC", "Microsoft YaHei", sans-serif;
            color: #333;
            padding-bottom: 40px;
        }
        .sub-head {
            background: #fff; padding: 10px 15px; border-bottom: 1px solid #eee;
            display: flex; align-items: center; gap: 8px; position: sticky; top: 36px; z-index: 999;
        }
        .sub-head .sub-title { flex: 1; font-size: 16px; font-weight: bold; }
        .btn {
            display: inline-block; height: 38px; padding: 0 14px; line-height: 36px;
            border: 1px solid transparent; border-radius: 6px; font-size: 14px; cursor: pointer;
            background: #1989fa; color: #fff; white-space: nowrap;
        }
        .btn.plain { background: #fff; color: #1989fa; border-color: #1989fa; }
        .btn.danger { background: #ee0a24; }
        .btn.warn { background: #ff976a; }
        .btn.small { height: 28px; line-height: 26px; padding: 0 10px; font-size: 12px; }
        .btn:active { opacity: .8; }
        .tabs {
            display: flex; background: #fff; border-bottom: 1px solid #eee;
            position: sticky; top: 90px; z-index: 998;
        }
        .tabs div {
            flex: 1; text-align: center; padding: 12px 0; font-size: 15px; cursor: pointer; color: #666;
            border-bottom: 2px solid transparent;
        }
        .tabs div.active { color: #1989fa; border-bottom-color: #1989fa; font-weight: bold; }
        .list { padding: 12px 15px; }
        .card {
            background: #fff; border-radius: 8px; padding: 12px 14px; margin-bottom: 12px;
            box-shadow: 0 1px 3px rgba(0,0,0,.06);
        }
        .card .row { display: flex; padding: 4px 0; font-size: 14px; }
        .card .row .k { width: 86px; color: #999; flex-shrink: 0; }
        .card .row .v { flex: 1; word-break: break-all; }
        .card .title { display: flex; justify-content: space-between; align-items: center; padding-bottom: 8px; border-bottom: 1px solid #f2f3f5; margin-bottom: 6px; }
        .card .title b { font-size: 16px; }
        .card .ops { display: flex; gap: 8px; }
        .empty { text-align: center; color: #999; padding: 40px 0; font-size: 14px; }
        .add-bar { padding: 0 15px 12px; }
        .add-bar .btn { width: 100%; height: 44px; line-height: 42px; text-align: center; }
        /* 账号卡片 */
        .acct-card { background: #fff; border-radius: 8px; padding: 14px; margin-bottom: 12px; box-shadow: 0 1px 3px rgba(0,0,0,.06); }
        .acct-card .head { display: flex; justify-content: space-between; align-items: center; margin-bottom: 6px; }
        .acct-card .phone { font-size: 17px; font-weight: bold; }
        .acct-card .meta { font-size: 13px; color: #666; margin-bottom: 10px; }
        .acct-card .pwd { font-size: 13px; color: #999; word-break: break-all; margin-bottom: 10px; }
        .acct-card .ops { display: flex; gap: 8px; flex-wrap: wrap; }
        .acct-card .ops .btn { flex: 1; text-align: center; }
        .modal-mask {
            position: fixed; inset: 0; background: rgba(0,0,0,.5); z-index: 10000;
            display: flex; align-items: flex-end; justify-content: center;
        }
        .modal {
            background: #fff; width: 100%; max-height: 88vh; overflow-y: auto;
            border-radius: 12px 12px 0 0; padding: 16px 15px 24px;
        }
        .modal h3 { text-align: center; font-size: 17px; margin-bottom: 14px; }
        .field { margin-bottom: 10px; }
        .field label { display: block; font-size: 13px; color: #666; margin-bottom: 4px; }
        .field input {
            width: 100%; height: 40px; border: 1px solid #dcdfe6; border-radius: 6px; padding: 0 10px; font-size: 14px;
        }
        .modal-ops { display: flex; gap: 10px; margin-top: 16px; }
        .modal-ops .btn { flex: 1; text-align: center; height: 44px; line-height: 42px; }
        .hidden { display: none !important; }
        .tip { color: #999; font-size: 12px; text-align: center; padding: 6px 0; }
        .photo-row { display: flex; align-items: center; gap: 12px; }
        .photo-box {
            width: 72px; height: 96px; border: 1px dashed #dcdfe6; border-radius: 6px;
            display: flex; align-items: center; justify-content: center; overflow: hidden;
            background: #fafafa; flex-shrink: 0;
        }
        .photo-preview { width: 100%; height: 100%; object-fit: cover; display: block; }
        .photo-empty { color: #c0c4cc; font-size: 12px; }
        .photo-ops { display: flex; flex-direction: column; gap: 8px; }
        .photo-pick { text-align: center; }
        .card .thumbs { display: flex; gap: 8px; padding: 4px 0; flex-wrap: wrap; }
        .card .thumb { width: 44px; height: 58px; border-radius: 4px; object-fit: cover; border: 1px solid #eee; background: #fafafa; }
        .card .thumb-wrap { display: flex; flex-direction: column; align-items: center; gap: 2px; }
        .card .thumb-wrap i { font-style: normal; font-size: 11px; color: #999; }
    </style>
</head>
<body>
    <!-- ============ 账号列表视图 ============ -->
    <div id="accountView">
        <div class="add-bar">
            <button class="btn" onclick="openAccountForm('')">＋ 新增账号</button>
        </div>
        <div class="list" id="accountListBox"></div>
    </div>

    <!-- ============ 账号数据视图 ============ -->
    <div id="dataView" class="hidden">
        <div class="sub-head">
            <button class="btn plain small" onclick="backToAccounts()">← 返回</button>
            <span class="sub-title" id="dataPhone"></span>
            <button class="btn warn small" onclick="openAccountForm(currentPhone)">改密码</button>
        </div>
        <div class="tabs">
            <div id="tabXj" class="active" onclick="switchTab('xj')">学籍信息</div>
            <div id="tabXl" onclick="switchTab('xl')">学历信息</div>
        </div>
        <div class="add-bar">
            <button class="btn" onclick="openForm(null)">＋ 新增当前类型记录</button>
        </div>
        <div class="list" id="listBox"></div>
    </div>

    <!-- ============ 账号弹窗 ============ -->
    <div class="modal-mask hidden" id="accountMask">
        <div class="modal">
            <h3 id="accountTitle">新增账号</h3>
            <div class="field">
                <label>手机号（登录账号）</label>
                <input id="accPhone" type="tel" maxlength="11" placeholder="11位手机号">
            </div>
            <div class="field">
                <label>密码</label>
                <input id="accPassword" type="text" placeholder="登录密码（本地验证用）">
            </div>
            <div class="modal-ops">
                <button class="btn plain" onclick="closeAccountForm()">取消</button>
                <button class="btn" onclick="saveAccount()">保存</button>
            </div>
        </div>
    </div>

    <!-- ============ 记录弹窗 ============ -->
    <div class="modal-mask hidden" id="modalMask">
        <div class="modal">
            <h3 id="formTitle">编辑记录</h3>
            <div id="formFields"></div>
            <div class="modal-ops">
                <button class="btn plain" onclick="closeForm()">取消</button>
                <button class="btn" onclick="saveForm()">保存</button>
            </div>
        </div>
    </div>

    <script>
        var FIELD_ORDER = {
            xj: ['xm','xb','csrq','mz','sfzh','yxmc','xsh','fy','zymc','cc','xxxs','xllb','xh','bh','rxrq','byrq','xjzt','xz','reportNo','verifyCode','validFrom','validTo','reportStatus'],
            xl: ['xm','xb','csrq','yxmc','zymc','cc','xxxs','xllb','zsbh','bjyjl','rxrq','byrq','xz','fzrq','xzm','reportNo','verifyCode','validFrom','validTo','reportStatus']
        };
        var FIELD_LABELS = {
            xj: { xm:'姓名', xb:'性别', csrq:'出生日期', mz:'民族', sfzh:'身份证号', yxmc:'院校名称', xsh:'院系', fy:'分院',
                  zymc:'专业名称', cc:'层次', xxxs:'学习形式', xllb:'学历类别', xh:'学号', bh:'班号',
                  rxrq:'入学日期', byrq:'离校日期', xjzt:'学籍状态', xz:'学制',
                  reportNo:'报告编号', verifyCode:'在线验证码', validFrom:'报告有效期起', validTo:'报告有效期止', reportStatus:'报告状态' },
            xl: { xm:'姓名', xb:'性别', csrq:'出生日期', yxmc:'院校名称', zymc:'专业名称', cc:'层次',
                  xxxs:'学习形式', xllb:'学历类别', zsbh:'证书编号', bjyjl:'毕结业结论', rxrq:'入学日期',
                  byrq:'毕业日期', xz:'学制', fzrq:'发证日期', xzm:'校（院）长姓名',
                  reportNo:'报告编号', verifyCode:'在线验证码', validFrom:'报告有效期起', validTo:'报告有效期止', reportStatus:'报告状态' }
        };
        var currentPhone = '';        // 当前管理的账号
        var currentType = 'xj';       // 当前 tab
        var currentData = { xj: [], xl: [] };
        var editingIndex = null;      // null = 新增
        var photoData = {};           // key: 'lqPic'|'xlPic' -> dataURL 或 ''
        var photoRemoved = {};        // key -> true 表示用户清除了该照片
        var editingAccountPhone = ''; // 账号弹窗：正在编辑的手机号（空=新增）

        // ================= 账号列表 =================
        function loadAccounts() {
            fetch('/api/admin/list')
                .then(function (r) { return r.json(); })
                .then(function (res) {
                    var accounts = res.accounts || {};
                    renderAccounts(accounts);
                })
                .catch(function (e) { alert('加载账号列表失败: ' + e.message); });
        }

        function renderAccounts(accounts) {
            var box = document.getElementById('accountListBox');
            var keys = Object.keys(accounts);
            if (keys.length === 0) {
                box.innerHTML = '<div class="empty">暂无本地维护账号，点击上方「新增账号」创建</div>';
                return;
            }
            var html = '';
            keys.forEach(function (phone) {
                var acc = accounts[phone] || {};
                var xjCount = (acc.xj || []).length;
                var xlCount = (acc.xl || []).length;
                var pwd = acc.password || '';
                html += '<div class="acct-card">' +
                    '<div class="head"><span class="phone">' + esc(phone) + '</span></div>' +
                    '<div class="pwd">密码：' + (pwd ? '<b>' + esc(pwd) + '</b>' : '<span style="color:#c0c4cc">（未设置，登录将走官方校验）</span>') + '</div>' +
                    '<div class="meta">学籍 <b>' + xjCount + '</b> 条 · 学历 <b>' + xlCount + '</b> 条</div>' +
                    '<div class="ops">' +
                    '<button class="btn" onclick="openAccount(\'' + esc(phone) + '\')">管理数据</button>' +
                    '<button class="btn warn small" onclick="openAccountForm(\'' + esc(phone) + '\')">改密码</button>' +
                    '<button class="btn danger small" onclick="deleteAccount(\'' + esc(phone) + '\')">删除</button>' +
                    '</div></div>';
            });
            box.innerHTML = html;
        }

        function openAccountForm(phone) {
            editingAccountPhone = phone;
            document.getElementById('accountTitle').textContent = phone ? '修改账号密码' : '新增账号';
            document.getElementById('accPhone').value = phone || '';
            document.getElementById('accPassword').value = '';
            if (phone) document.getElementById('accPhone').disabled = true;
            else document.getElementById('accPhone').disabled = false;
            document.getElementById('accountMask').className = 'modal-mask';
            if (!phone) document.getElementById('accPhone').focus();
        }

        function closeAccountForm() {
            document.getElementById('accountMask').className = 'modal-mask hidden';
            editingAccountPhone = '';
        }

        function saveAccount() {
            var phone = document.getElementById('accPhone').value.trim();
            var password = document.getElementById('accPassword').value;
            if (!/^1\d{10}$/.test(phone)) { alert('请输入正确的11位手机号'); return; }
            if (editingAccountPhone && phone !== editingAccountPhone) {
                phone = editingAccountPhone;
            }
            var body = new URLSearchParams();
            body.append('phone', phone);
            body.append('password', password);
            fetch('/api/admin/account/save', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
                body: body.toString()
            })
                .then(function (r) { return r.json(); })
                .then(function (res) {
                    if (res.success) { closeAccountForm(); loadAccounts(); alert('保存成功'); }
                    else { alert('保存失败: ' + res.message); }
                })
                .catch(function (e) { alert('保存失败: ' + e.message); });
        }

        function deleteAccount(phone) {
            if (!confirm('确定删除账号 ' + phone + ' 及其全部学籍/学历数据吗？')) return;
            var body = new URLSearchParams();
            body.append('phone', phone);
            fetch('/api/admin/account/delete', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
                body: body.toString()
            })
                .then(function (r) { return r.json(); })
                .then(function (res) {
                    if (res.success) { loadAccounts(); alert('删除成功'); }
                    else { alert('删除失败: ' + res.message); }
                })
                .catch(function (e) { alert('删除失败: ' + e.message); });
        }

        // ================= 账号数据管理 =================
        function openAccount(phone) {
            currentPhone = phone;
            currentType = 'xj';
            document.getElementById('dataPhone').textContent = phone;
            document.getElementById('accountView').className = 'hidden';
            document.getElementById('dataView').className = '';
            loadData(phone);
        }

        function backToAccounts() {
            document.getElementById('dataView').className = 'hidden';
            document.getElementById('accountView').className = '';
            loadAccounts();
        }

        function loadData(phone) {
            fetch('/api/admin/list?phone=' + encodeURIComponent(phone))
                .then(function (r) { return r.json(); })
                .then(function (res) {
                    currentData = { xj: res.xj || [], xl: res.xl || [] };
                    switchTab(currentType);
                })
                .catch(function (e) { alert('加载失败: ' + e.message); });
        }

        function switchTab(t) {
            currentType = t;
            document.getElementById('tabXj').className = (t === 'xj') ? 'active' : '';
            document.getElementById('tabXl').className = (t === 'xl') ? 'active' : '';
            renderList();
        }

        function renderList() {
            var box = document.getElementById('listBox');
            var arr = currentData[currentType] || [];
            if (arr.length === 0) {
                box.innerHTML = '<div class="empty">暂无' + (currentType === 'xj' ? '学籍' : '学历') + '数据，点击上方按钮新增</div>';
                return;
            }
            var html = '';
            arr.forEach(function (item, idx) {
                html += '<div class="card"><div class="title"><b>#' + (idx + 1) + '</b>' +
                    '<div class="ops">' +
                    '<button class="btn plain small" onclick="openForm(' + idx + ')">编辑</button>' +
                    '<button class="btn danger small" onclick="delRecord(' + idx + ')">删除</button>' +
                    '</div></div>';
                FIELD_ORDER[currentType].forEach(function (f) {
                    var v = item[f];
                    if (v === undefined || v === null || v === '') return;
                    html += '<div class="row"><span class="k">' + (FIELD_LABELS[currentType][f] || f) + '</span>' +
                        '<span class="v">' + esc(v) + '</span></div>';
                });
                // 照片缩略图
                var thumbs = '';
                if (item.lqPic) thumbs += '<div class="thumb-wrap"><img class="thumb" src="' + photoPreviewSrc(item.lqPic) + '"><i>录取</i></div>';
                if (item.xlPic) thumbs += '<div class="thumb-wrap"><img class="thumb" src="' + photoPreviewSrc(item.xlPic) + '"><i>学历</i></div>';
                if (thumbs) html += '<div class="thumbs">' + thumbs + '</div>';
                html += '</div>';
            });
            box.innerHTML = html;
        }

        function esc(s) {
            return String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
                .replace(/"/g, '&quot;').replace(/'/g, '&#39;');
        }

        function openForm(idx) {
            editingIndex = idx;
            var fields = FIELD_ORDER[currentType];
            var item = (idx !== null) ? (currentData[currentType][idx] || {}) : {};
            photoData = {};
            photoRemoved = {};
            var photoKeys = (currentType === 'xj') ? ['lqPic', 'xlPic'] : ['xlPic'];
            photoKeys.forEach(function (k) { photoData[k] = item[k] || ''; });
            var html = '';
            fields.forEach(function (f) {
                var v = item[f] !== undefined ? item[f] : '';
                html += '<div class="field"><label>' + (FIELD_LABELS[currentType][f] || f) + '</label>' +
                    '<input id="f_' + f + '" type="text" value="' + esc(v) + '"></div>';
            });
            if (currentType === 'xj') {
                html += photoFieldHtml('lqPic', '录取照片');
                html += photoFieldHtml('xlPic', '学历照片');
            } else {
                html += photoFieldHtml('xlPic', '学历照片');
            }
            document.getElementById('formTitle').textContent =
                (idx !== null ? '编辑' : '新增') + (currentType === 'xj' ? '学籍' : '学历') + '记录';
            document.getElementById('formFields').innerHTML = html;
            document.getElementById('modalMask').className = 'modal-mask';
        }

        function photoPreviewSrc(src) {
            // 图片 URL 加时间戳绕过浏览器缓存；dataURL 原样返回
            if (!src) return '';
            if (src.indexOf('data:') === 0) return src;
            return src + (src.indexOf('?') === -1 ? '?_=' : '&_=') + Date.now();
        }

        function photoFieldHtml(key, label) {
            var src = photoPreviewSrc(photoData[key] || '');
            return '<div class="field"><label>' + label + '</label>' +
                '<div class="photo-row">' +
                '<div class="photo-box" id="pb_' + key + '">' +
                (src ? '<img class="photo-preview" src="' + src + '">' : '<span class="photo-empty">暂无照片</span>') +
                '</div>' +
                '<div class="photo-ops">' +
                '<label class="btn small plain photo-pick">选择照片<input type="file" accept="image/*" onchange="onPickPhoto(\'' + key + '\', this)" hidden></label>' +
                '<button class="btn small danger" onclick="clearPhoto(\'' + key + '\')">清除</button>' +
                '</div></div></div>';
        }

        function renderPhotoPreview(key) {
            var box = document.getElementById('pb_' + key);
            if (!box) return;
            var src = photoPreviewSrc(photoData[key] || '');
            box.innerHTML = src
                ? '<img class="photo-preview" src="' + src + '">'
                : '<span class="photo-empty">暂无照片</span>';
        }

        function onPickPhoto(key, input) {
            var file = input.files && input.files[0];
            if (!file) return;
            if (file.size > 5 * 1024 * 1024) { alert('图片不能超过 5MB'); input.value = ''; return; }
            var reader = new FileReader();
            reader.onload = function () {
                photoData[key] = reader.result;
                photoRemoved[key] = false;
                renderPhotoPreview(key);
            };
            reader.readAsDataURL(file);
        }

        function clearPhoto(key) {
            photoData[key] = '';
            photoRemoved[key] = true;
            renderPhotoPreview(key);
        }

        function closeForm() {
            document.getElementById('modalMask').className = 'modal-mask hidden';
            editingIndex = null;
        }

        function saveForm() {
            var phone = currentPhone;
            if (!phone) { alert('请先选择账号'); return; }
            var fields = FIELD_ORDER[currentType];
            var body = new URLSearchParams();
            body.append('phone', phone);
            body.append('type', currentType);
            if (editingIndex !== null) body.append('index', String(editingIndex));
            fields.forEach(function (f) {
                var v = document.getElementById('f_' + f).value;
                if (v !== '') body.append(f, v);
            });
            var photoKeys = (currentType === 'xj') ? ['lqPic', 'xlPic'] : ['xlPic'];
            photoKeys.forEach(function (k) {
                if (photoData[k]) body.append(k, photoData[k]);
                else if (photoRemoved[k]) body.append(k, '');
            });
            fetch('/api/admin/save', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
                body: body.toString()
            })
                .then(function (r) { return r.json(); })
                .then(function (res) {
                    if (res.success) { closeForm(); loadData(currentPhone); alert('保存成功'); }
                    else { alert('保存失败: ' + res.message); }
                })
                .catch(function (e) { alert('保存失败: ' + e.message); });
        }

        function delRecord(idx) {
            var phone = currentPhone;
            if (!phone) { alert('请先选择账号'); return; }
            if (!confirm('确定删除第 ' + (idx + 1) + ' 条记录吗？')) return;
            var body = new URLSearchParams();
            body.append('phone', phone);
            body.append('type', currentType);
            body.append('index', String(idx));
            fetch('/api/admin/delete', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
                body: body.toString()
            })
                .then(function (r) { return r.json(); })
                .then(function (res) {
                    if (res.success) { loadData(currentPhone); alert('删除成功'); }
                    else { alert('删除失败: ' + res.message); }
                })
                .catch(function (e) { alert('删除失败: ' + e.message); });
        }

        // 打开页面自动加载账号列表
        loadAccounts();
    </script>
</body>
</html>
