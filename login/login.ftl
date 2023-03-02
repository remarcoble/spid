<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
    <div id="kc-form">
      <div id="kc-form-wrapper">
        <#if realm.password>
            <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                <#if !usernameHidden??>
                    <div class="${properties.kcFormGroupClass!}">
                        <label for="username" class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>

                        <input tabindex="1" id="username" class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}"  type="text" autofocus autocomplete="off"
                               aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                        />

                        <#if messagesPerField.existsError('username','password')>
                            <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                    ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                            </span>
                        </#if>

                    </div>
                </#if>

                <div class="${properties.kcFormGroupClass!}">
                    <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>

                    <input tabindex="2" id="password" class="${properties.kcInputClass!}" name="password" type="password" autocomplete="off"
                           aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                    />

                    <#if usernameHidden?? && messagesPerField.existsError('username','password')>
                        <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                        </span>
                    </#if>

                </div>

                <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                    <div id="kc-form-options">
                        <#if realm.rememberMe && !usernameHidden??>
                            <div class="checkbox">
                                <label>
                                    <#if login.rememberMe??>
                                        <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
                                    <#else>
                                        <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
                                    </#if>
                                </label>
                            </div>
                        </#if>
                        </div>
                        <div class="${properties.kcFormOptionsWrapperClass!}">
                            <#if realm.resetPasswordAllowed>
                                <span><a tabindex="5" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></span>
                            </#if>
                        </div>

                  </div>

                  <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                      <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                      <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                  </div>
            </form>
        </#if>
        </div>

    </div>
    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration-container">
                <div id="kc-registration">
                    <span>${msg("noAccount")} <a tabindex="6"
                                                 href="${url.registrationUrl}">${msg("doRegister")}</a></span>
                </div>
            </div>
        </#if>
    <#elseif section = "socialProviders" >
        <#if realm.password && social.providers??>
            <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
                <hr/>
                <h4>${msg("identity-provider-login-label")}</h4>
                <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
                    <#list social.providers as p>
                        <#if p.providerId != "spid">
                            <a id="social-${p.alias}" class="${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>"
                                    type="button" href="${p.loginUrl}">
                                <#if p.iconClasses?has_content>
                                    <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                    <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                                <#else>
                                    <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                                </#if>
                            </a>
                        </#if>
                    </#list>
                </ul>

                <div id="spidWrapper">
                    <a href="#" class="italia-it-button italia-it-button-size-m button-spid" spid-idp-button="#spid-idp-button-xlarge-get" aria-haspopup="true" aria-expanded="false">
                        <span class="italia-it-button-icon"><img src="${url.resourcesPath}/img/spid-ico-circle-bb.svg" onerror="this.src='${url.resourcesPath}/img/spid-ico-circle-bb.png'; this.onerror=null;" alt="" /></span>
                        <span class="italia-it-button-text">Entra con SPID</span>
                    </a>
                    <div id="spid-idp-button-xlarge-get" class="spid-idp-button spid-idp-button-tip spid-idp-button-relative">
                        <ul id="spid-idp-list-xlarge-root-get" class="spid-idp-button-menu" aria-labelledby="spid-idp">
                            <li class="spid-idp-button-link" data-idp="spid-aruba">
                                <a href="#"><span class="spid-sr-only">Aruba ID</span><img src="${url.resourcesPath}/img/spid-idp-arubaid.svg" onerror="this.src='${url.resourcesPath}/img/spid-idp-arubaid.png'; this.onerror=null;" alt="Aruba ID" /></a>
                            </li>
                            <li class="spid-idp-button-link" data-idp="spid-infocert">
                                <a href="#"><span class="spid-sr-only">Infocert ID</span><img src="${url.resourcesPath}/img/spid-idp-infocertid.svg" onerror="this.src='${url.resourcesPath}/img/spid-idp-infocertid.png'; this.onerror=null;" alt="Infocert ID" /></a>
                            </li>
                            <li class="spid-idp-button-link" data-idp="spid-intesa">
                                <a href="#"><span class="spid-sr-only">Intesa ID</span><img src="${url.resourcesPath}/img/spid-idp-intesaid.svg" onerror="this.src='${url.resourcesPath}/img/spid-idp-intesaid.png'; this.onerror=null;" alt="Intesa ID" /></a>
                            </li>
                            <li class="spid-idp-button-link" data-idp="spid-lepida">
                                <a href="#"><span class="spid-sr-only">Lepida ID</span><img src="${url.resourcesPath}/img/spid-idp-lepidaid.svg" onerror="this.src='${url.resourcesPath}/img/spid-idp-lepidaid.png'; this.onerror=null;" alt="Lepida ID" /></a>
                            </li>
                            <li class="spid-idp-button-link" data-idp="spid-namirial">
                                <a href="#"><span class="spid-sr-only">Namirial ID</span><img src="${url.resourcesPath}/img/spid-idp-namirialid.svg" onerror="this.src='${url.resourcesPath}/img/spid-idp-namirialid.png'; this.onerror=null;" alt="Namirial ID" /></a>
                            </li>
                            <li class="spid-idp-button-link" data-idp="spid-poste">
                                <a href="#"><span class="spid-sr-only">Poste ID</span><img src="${url.resourcesPath}/img/spid-idp-posteid.svg" onerror="this.src='${url.resourcesPath}/img/spid-idp-posteid.png'; this.onerror=null;" alt="Poste ID" /></a>
                            </li>
                            <li class="spid-idp-button-link" data-idp="spid-sielte">
                                <a href="#"><span class="spid-sr-only">Sielte ID</span><img src="${url.resourcesPath}/img/spid-idp-sielteid.svg" onerror="this.src='${url.resourcesPath}/img/spid-idp-sielteid.png'; this.onerror=null;" alt="Sielte ID" /></a>
                            </li>
                            <li class="spid-idp-button-link" data-idp="spid-register.it">
                                <a href="#"><span class="spid-sr-only">SPIDItalia Register.it</span><img src="${url.resourcesPath}/img/spid-idp-spiditalia.svg" onerror="this.src='${url.resourcesPath}/img/spid-idp-spiditalia.png'; this.onerror=null;" alt="SpidItalia" /></a>
                            </li>
                            <li class="spid-idp-button-link" data-idp="spid-teamsystem">
                                <a href="#"><span class="spid-sr-only">TeamSystem ID</span><img src="${url.resourcesPath}/img/spid-idp-teamsystemid.svg" onerror="this.src='${url.resourcesPath}/img/spid-idp-teamsystemid.png'; this.onerror=null;" alt="TeamSystem ID" /></a>
                            </li>
                            <li class="spid-idp-button-link" data-idp="spid-tim">
                                <a href="#"><span class="spid-sr-only">Tim ID</span><img src="${url.resourcesPath}/img/spid-idp-timid.svg" onerror="this.src='${url.resourcesPath}/img/spid-idp-timid.png'; this.onerror=null;" alt="Tim ID" /></a>
                            </li>
                            <li class="spid-idp-button-link" data-idp="spid-validator">
                                <a href="#"><span class="spid-sr-only">SPID Validator</span><img src="" alt="SPID Validator" /></a>
                            </li>
                            <li class="spid-idp-button-link" data-idp="spid-demo">
                                <a href="#"><span class="spid-sr-only">SPID Demo</span><img src="" alt="SPID Demo" /></a>
                            </li>
                            <li class="spid-idp-support-link" data-spidlink="info">
                                <a href="https://www.spid.gov.it">Maggiori informazioni</a>
                            </li>
                            <li class="spid-idp-support-link" data-spidlink="rich">
                                <a href="https://www.spid.gov.it/richiedi-spid">Non hai SPID?</a>
                            </li>
                            <li class="spid-idp-support-link" data-spidlink="help">
                                <a href="https://www.spid.gov.it/serve-aiuto">Serve aiuto?</a>
                            </li>
                        </ul>
                    </div>

                    <script src="${url.resourcesPath}/js/jquery.min.js"></script>
                    <script src="${url.resourcesPath}/js/spid-sp-access-button.min.js"></script>

                    <script>
                        var SPID_KEYCLOAK = {
                            spidproviders: {
                                <#list social.providers as p>
                                    <#if p.providerId = "spid">
                                    "${p.alias}": "${p.loginUrl?no_esc}",
                                    </#if>
                                </#list>
                            },
                            randomizeSpidLinks: function() {
                                var rootList = $("#spid-idp-list-xlarge-root-get");
                                var idpList = rootList.children(".spid-idp-button-link");
                                var lnkList = rootList.children(".spid-idp-support-link");
                                while (idpList.length) {
                                    rootList.append(idpList.splice(Math.floor(Math.random() * idpList.length), 1)[0]);
                                }
                                rootList.append(lnkList);
                            },
                            updateSpidLinks: function() {
                                if (SPID_KEYCLOAK.spidproviders.length == 0) {
                                    $('#spidWrapper').remove();
                                    return;
                                }
                                var countIdp = 0;
                                $('li.spid-idp-button-link a').each(function(i, item) {
                                    var link = $(item);
                                    var idpId = link.parent().attr('data-idp');
                                    if (undefined != SPID_KEYCLOAK.spidproviders[idpId]) {
                                        link.attr('href', SPID_KEYCLOAK.spidproviders[idpId]);
                                        countIdp++;
                                    } else {
                                        link.parent().remove();
                                    }
                                });  
                                if (countIdp == 0) {
                                    $('#spidWrapper').remove();
                                }                              
                            }
                        };
                        $(document).ready(function(){
                            SPID_KEYCLOAK.randomizeSpidLinks();
                            SPID_KEYCLOAK.updateSpidLinks();
                        });
                    </script>
                </div>
                <p class="text-center">SPID è il sistema di accesso che consente di utilizzare, con un'identità digitale unica, i servizi online della Pubblica Amministrazione e dei privati accreditati.</p>
            </div>
        </#if>
    </#if>

</@layout.registrationLayout>
