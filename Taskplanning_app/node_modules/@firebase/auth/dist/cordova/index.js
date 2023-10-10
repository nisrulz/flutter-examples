import { getApp, _getProvider } from '@firebase/app';
import { _ as _signInWithRedirect, a as _reauthenticateWithRedirect, b as _linkWithRedirect, r as registerAuth, i as initializeAuth, c as indexedDBLocalPersistence, d as cordovaPopupRedirectResolver } from './popup_redirect-0a78e29a.js';
export { A as ActionCodeOperation, a5 as ActionCodeURL, x as AuthCredential, t as AuthErrorCodes, E as EmailAuthCredential, C as EmailAuthProvider, D as FacebookAuthProvider, F as FactorId, H as GithubAuthProvider, G as GoogleAuthProvider, y as OAuthCredential, I as OAuthProvider, O as OperationType, z as PhoneAuthCredential, P as ProviderId, J as SAMLAuthProvider, S as SignInMethod, T as TwitterAuthProvider, V as applyActionCode, j as beforeAuthStateChanged, e as browserLocalPersistence, f as browserSessionPersistence, W as checkActionCode, U as confirmPasswordReset, w as connectAuthEmulator, d as cordovaPopupRedirectResolver, Y as createUserWithEmailAndPassword, p as debugErrorMap, n as deleteUser, a2 as fetchSignInMethodsForEmail, ad as getAdditionalUserInfo, aa as getIdToken, ab as getIdTokenResult, af as getMultiFactorResolver, g as getRedirectResult, B as inMemoryPersistence, c as indexedDBLocalPersistence, i as initializeAuth, h as initializeRecaptchaConfig, a0 as isSignInWithEmailLink, M as linkWithCredential, ag as multiFactor, k as onAuthStateChanged, o as onIdTokenChanged, a6 as parseActionCodeURL, q as prodErrorMap, N as reauthenticateWithCredential, ae as reload, a3 as sendEmailVerification, R as sendPasswordResetEmail, $ as sendSignInLinkToEmail, s as setPersistence, K as signInAnonymously, L as signInWithCredential, Q as signInWithCustomToken, Z as signInWithEmailAndPassword, a1 as signInWithEmailLink, m as signOut, ac as unlink, l as updateCurrentUser, a8 as updateEmail, a9 as updatePassword, a7 as updateProfile, u as useDeviceLanguage, v as validatePassword, a4 as verifyBeforeUpdateEmail, X as verifyPasswordResetCode } from './popup_redirect-0a78e29a.js';
import 'tslib';
import '@firebase/util';
import '@firebase/component';
import '@firebase/logger';

/**
 * @license
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
function signInWithRedirect(auth, provider, resolver) {
    return _signInWithRedirect(auth, provider, resolver);
}
function reauthenticateWithRedirect(user, provider, resolver) {
    return _reauthenticateWithRedirect(user, provider, resolver);
}
function linkWithRedirect(user, provider, resolver) {
    return _linkWithRedirect(user, provider, resolver);
}

/**
 * @license
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
function getAuth(app) {
    if (app === void 0) { app = getApp(); }
    var provider = _getProvider(app, 'auth');
    if (provider.isInitialized()) {
        return provider.getImmediate();
    }
    return initializeAuth(app, {
        persistence: indexedDBLocalPersistence,
        popupRedirectResolver: cordovaPopupRedirectResolver
    });
}
registerAuth("Cordova" /* ClientPlatform.CORDOVA */);

export { getAuth, linkWithRedirect, reauthenticateWithRedirect, signInWithRedirect };
//# sourceMappingURL=index.js.map
