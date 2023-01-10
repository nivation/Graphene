package require topotools                                                                                                  
mol new "Graphene_Agar_water.psf" type psf                                                                                 
mol addfile 2500_2999.dcd type dcd first 0 last -1 step 1 waitfor -1                                   
pbc wrap -center com -centersel "fragment 0 9537 to 9556" -compound fragment -all                                                        
                                                                                                                           
set outfile [open "Atom_type_2500_2999.data" w]                                                                                      
set g [atomselect top "fragment 0 and name C3"]                                                                            
set g_serial [$g get serial]                                                                                               
set total [molinfo top get numframes]                                                                                           
puts $outfile "frame serial Ceth Heth Obr Or Oor Ohyd Hchyd Hhyd Chyd H2O dH2O"                                                                                           
                                                                                                                           
for {set i 0} {$i <= $total} {incr i} {      
	animate goto $i                    
	[atomselect top "all"] move [transaxis x -25]
	[atomselect top "all"] move [transaxis z -20]
	foreach serial $g_serial {                                                                                               
	                                                                                                                         
		set n_Ceth   0                                                                                                          
		set n_Heth   0                                                                                                          
		set n_Obr    0                                                                                                       
		set n_Or     0                                                                                                          
		set n_Oor    0                                                                                                       
		set n_Ohyd   0                                                                                                       
		set n_Hchyd  0                                                                                                       
		set n_Hhyd   0                                                                                                         
		set n_Chyd   0                                                                                                       
		set n_H2O    0                                                                                                      
		set n_dH2O   0
		
		set dis 3.5                                                                                                          
		                                                                                                                     
		set Ceth_flag    0                                                                                                  
		set Heth_flag    0                                                                                                 
		set Obr_flag     0                                                                                                  
		set Or_flag      0                                                                                                  
		set Oor_flag     0                                                                                               
		set Ohyd_flag    0                                                                                               
		set Hchyd_flag   0                                                                                               
		set Hhyd_flag    0                                                                                               
		set Chyd_flag    0                                                                                              
		set H2O_flag     0
        set dH2O_flag    0
		
		                                                                                                                     
		set g_atom [atomselect top "serial $serial"]                                                                                
		set y [$g_atom get y]         

		set Ceth    [atomselect top "(within ${dis} of serial ${serial}) and index 30276	30278	30279	30280	30281	30286	30288	30290	30297	30299	30300	30301	30302	30307	30309	30311	30318	30320	30321	30322	30323	30328	30332	30339	30341	30342	30343	30344	30349	30351	30353	30360	30362	30363	30364	30365	30370	30372	30374	30381	30383	30384	30385	30386	30391	30395
30514	30516	30517	30518	30519	30524	30526	30528	30535	30537	30538	30539	30540	30545	30547	30549	30556	30558	30559	30560	30561	30566	30570	30577	30579	30580	30581	30582	30587	30589	30591	30598	30600	30601	30602	30603	30608	30610	30612	30619	30621	30622	30623	30624	30629	30633
30752	30754	30755	30756	30757	30762	30764	30766	30773	30775	30776	30777	30778	30783	30785	30787	30794	30796	30797	30798	30799	30804	30808	30815	30817	30818	30819	30820	30825	30827	30829	30836	30838	30839	30840	30841	30846	30848	30850	30857	30859	30860	30861	30862	30867	30871
30990	30992	30993	30994	30995	31000	31002	31004	31011	31013	31014	31015	31016	31021	31023	31025	31032	31034	31035	31036	31037	31042	31046	31053	31055	31056	31057	31058	31063	31065	31067	31074	31076	31077	31078	31079	31084	31086	31088	31095	31097	31098	31099	31100	31105	31109
31228	31230	31231	31232	31233	31238	31240	31242	31249	31251	31252	31253	31254	31259	31261	31263	31270	31272	31273	31274	31275	31280	31284	31291	31293	31294	31295	31296	31301	31303	31305	31312	31314	31315	31316	31317	31322	31324	31326	31333	31335	31336	31337	31338	31343	31347
31466	31468	31469	31470	31471	31476	31478	31480	31487	31489	31490	31491	31492	31497	31499	31501	31508	31510	31511	31512	31513	31518	31522	31529	31531	31532	31533	31534	31539	31541	31543	31550	31552	31553	31554	31555	31560	31562	31564	31571	31573	31574	31575	31576	31581	31585
31704	31706	31707	31708	31709	31714	31716	31718	31725	31727	31728	31729	31730	31735	31737	31739	31746	31748	31749	31750	31751	31756	31760	31767	31769	31770	31771	31772	31777	31779	31781	31788	31790	31791	31792	31793	31798	31800	31802	31809	31811	31812	31813	31814	31819	31823
31942	31944	31945	31946	31947	31952	31954	31956	31963	31965	31966	31967	31968	31973	31975	31977	31984	31986	31987	31988	31989	31994	31998	32005	32007	32008	32009	32010	32015	32017	32019	32026	32028	32029	32030	32031	32036	32038	32040	32047	32049	32050	32051	32052	32057	32061
32180	32182	32183	32184	32185	32190	32192	32194	32201	32203	32204	32205	32206	32211	32213	32215	32222	32224	32225	32226	32227	32232	32236	32243	32245	32246	32247	32248	32253	32255	32257	32264	32266	32267	32268	32269	32274	32276	32278	32285	32287	32288	32289	32290	32295	32299
32418	32420	32421	32422	32423	32428	32430	32432	32439	32441	32442	32443	32444	32449	32451	32453	32460	32462	32463	32464	32465	32470	32474	32481	32483	32484	32485	32486	32491	32493	32495	32502	32504	32505	32506	32507	32512	32514	32516	32523	32525	32526	32527	32528	32533	32537
"]
		set Heth    [atomselect top "(within ${dis} of serial ${serial}) and index 30402	30403	30405	30406	30407	30408	30409	30411	30413	30415	30421	30423	30424	30425	30426	30427	30429	30431	30433	30439	30441	30442	30443	30444	30445	30447	30451	30458	30459	30461	30462	30463	30464	30465	30467	30469	30471	30477	30479	30480	30481	30482	30483	30485	30487	30489	30495	30497	30498	30499	30500	30501	30503	30507
30640	30641	30643	30644	30645	30646	30647	30649	30651	30653	30659	30661	30662	30663	30664	30665	30667	30669	30671	30677	30679	30680	30681	30682	30683	30685	30689	30696	30697	30699	30700	30701	30702	30703	30705	30707	30709	30715	30717	30718	30719	30720	30721	30723	30725	30727	30733	30735	30736	30737	30738	30739	30741	30745
30878	30879	30881	30882	30883	30884	30885	30887	30889	30891	30897	30899	30900	30901	30902	30903	30905	30907	30909	30915	30917	30918	30919	30920	30921	30923	30927	30934	30935	30937	30938	30939	30940	30941	30943	30945	30947	30953	30955	30956	30957	30958	30959	30961	30963	30965	30971	30973	30974	30975	30976	30977	30979	30983
31116	31117	31119	31120	31121	31122	31123	31125	31127	31129	31135	31137	31138	31139	31140	31141	31143	31145	31147	31153	31155	31156	31157	31158	31159	31161	31165	31172	31173	31175	31176	31177	31178	31179	31181	31183	31185	31191	31193	31194	31195	31196	31197	31199	31201	31203	31209	31211	31212	31213	31214	31215	31217	31221
31354	31355	31357	31358	31359	31360	31361	31363	31365	31367	31373	31375	31376	31377	31378	31379	31381	31383	31385	31391	31393	31394	31395	31396	31397	31399	31403	31410	31411	31413	31414	31415	31416	31417	31419	31421	31423	31429	31431	31432	31433	31434	31435	31437	31439	31441	31447	31449	31450	31451	31452	31453	31455	31459
31592	31593	31595	31596	31597	31598	31599	31601	31603	31605	31611	31613	31614	31615	31616	31617	31619	31621	31623	31629	31631	31632	31633	31634	31635	31637	31641	31648	31649	31651	31652	31653	31654	31655	31657	31659	31661	31667	31669	31670	31671	31672	31673	31675	31677	31679	31685	31687	31688	31689	31690	31691	31693	31697
31830	31831	31833	31834	31835	31836	31837	31839	31841	31843	31849	31851	31852	31853	31854	31855	31857	31859	31861	31867	31869	31870	31871	31872	31873	31875	31879	31886	31887	31889	31890	31891	31892	31893	31895	31897	31899	31905	31907	31908	31909	31910	31911	31913	31915	31917	31923	31925	31926	31927	31928	31929	31931	31935
32068	32069	32071	32072	32073	32074	32075	32077	32079	32081	32087	32089	32090	32091	32092	32093	32095	32097	32099	32105	32107	32108	32109	32110	32111	32113	32117	32124	32125	32127	32128	32129	32130	32131	32133	32135	32137	32143	32145	32146	32147	32148	32149	32151	32153	32155	32161	32163	32164	32165	32166	32167	32169	32173
32306	32307	32309	32310	32311	32312	32313	32315	32317	32319	32325	32327	32328	32329	32330	32331	32333	32335	32337	32343	32345	32346	32347	32348	32349	32351	32355	32362	32363	32365	32366	32367	32368	32369	32371	32373	32375	32381	32383	32384	32385	32386	32387	32389	32391	32393	32399	32401	32402	32403	32404	32405	32407	32411
32544	32545	32547	32548	32549	32550	32551	32553	32555	32557	32563	32565	32566	32567	32568	32569	32571	32573	32575	32581	32583	32584	32585	32586	32587	32589	32593	32600	32601	32603	32604	32605	32606	32607	32609	32611	32613	32619	32621	32622	32623	32624	32625	32627	32629	32631	32637	32639	32640	32641	32642	32643	32645	32649
"]
		set Obr     [atomselect top "(within ${dis} of serial ${serial}) and index 30284	30293	30305	30314	30326	30347	30356	30368	30377	30389
30522	30531	30543	30552	30564	30585	30594	30606	30615	30627
30760	30769	30781	30790	30802	30823	30832	30844	30853	30865
30998	31007	31019	31028	31040	31061	31070	31082	31091	31103
31236	31245	31257	31266	31278	31299	31308	31320	31329	31341
31474	31483	31495	31504	31516	31537	31546	31558	31567	31579
31712	31721	31733	31742	31754	31775	31784	31796	31805	31817
31950	31959	31971	31980	31992	32013	32022	32034	32043	32055
32188	32197	32209	32218	32230	32251	32260	32272	32281	32293
32426	32435	32447	32456	32468	32489	32498	32510	32519	32531
"]
		set Or      [atomselect top "(within ${dis} of serial ${serial}) and index 30285	30295	30306	30316	30327	30337	30348	30358	30369	30379	30390	30400
30523	30533	30544	30554	30565	30575	30586	30596	30607	30617	30628	30638
30761	30771	30782	30792	30803	30813	30824	30834	30845	30855	30866	30876
30999	31009	31020	31030	31041	31051	31062	31072	31083	31093	31104	31114
31237	31247	31258	31268	31279	31289	31300	31310	31321	31331	31342	31352
31475	31485	31496	31506	31517	31527	31538	31548	31559	31569	31580	31590
31713	31723	31734	31744	31755	31765	31776	31786	31797	31807	31818	31828
31951	31961	31972	31982	31993	32003	32014	32024	32035	32045	32056	32066
32189	32199	32210	32220	32231	32241	32252	32262	32273	32283	32294	32304
32427	32437	32448	32458	32469	32479	32490	32500	32511	32521	32532	32542
"]
		set Oor     [atomselect top "(within ${dis} of serial ${serial}) and index 30283	30304	30325	30346	30367	30388
30521	30542	30563	30584	30605	30626
30759	30780	30801	30822	30843	30864
30997	31018	31039	31060	31081	31102
31235	31256	31277	31298	31319	31340
31473	31494	31515	31536	31557	31578
31711	31732	31753	31774	31795	31816
31949	31970	31991	32012	32033	32054
32187	32208	32229	32250	32271	32292
32425	32446	32467	32488	32509	32530
"]
		set Ohyd    [atomselect top "(within ${dis} of serial ${serial}) and index 30282	30292	30294	30296	30303	30313	30315	30317	30324	30334	30335	30336	30338	30345	30355	30357	30359	30366	30376	30378	30380	30387	30397	30398	30399	30401
30520	30530	30532	30534	30541	30551	30553	30555	30562	30572	30573	30574	30576	30583	30593	30595	30597	30604	30614	30616	30618	30625	30635	30636	30637	30639
30758	30768	30770	30772	30779	30789	30791	30793	30800	30810	30811	30812	30814	30821	30831	30833	30835	30842	30852	30854	30856	30863	30873	30874	30875	30877
30996	31006	31008	31010	31017	31027	31029	31031	31038	31048	31049	31050	31052	31059	31069	31071	31073	31080	31090	31092	31094	31101	31111	31112	31113	31115
31234	31244	31246	31248	31255	31265	31267	31269	31276	31286	31287	31288	31290	31297	31307	31309	31311	31318	31328	31330	31332	31339	31349	31350	31351	31353
31472	31482	31484	31486	31493	31503	31505	31507	31514	31524	31525	31526	31528	31535	31545	31547	31549	31556	31566	31568	31570	31577	31587	31588	31589	31591
31710	31720	31722	31724	31731	31741	31743	31745	31752	31762	31763	31764	31766	31773	31783	31785	31787	31794	31804	31806	31808	31815	31825	31826	31827	31829
31948	31958	31960	31962	31969	31979	31981	31983	31990	32000	32001	32002	32004	32011	32021	32023	32025	32032	32042	32044	32046	32053	32063	32064	32065	32067
32186	32196	32198	32200	32207	32217	32219	32221	32228	32238	32239	32240	32242	32249	32259	32261	32263	32270	32280	32282	32284	32291	32301	32302	32303	32305
32424	32434	32436	32438	32445	32455	32457	32459	32466	32476	32477	32478	32480	32487	32497	32499	32501	32508	32518	32520	32522	32529	32539	32540	32541	32543
"]
		set Hchyd   [atomselect top "(within ${dis} of serial ${serial}) and index 30404	30412	30414	30416	30417	30422	30430	30432	30434	30435	30440	30448	30449	30450	30452	30453	30460	30468	30470	30472	30473	30478	30486	30488	30490	30491	30496	30504	30505	30506	30508	30509
30642	30650	30652	30654	30655	30660	30668	30670	30672	30673	30678	30686	30687	30688	30690	30691	30698	30706	30708	30710	30711	30716	30724	30726	30728	30729	30734	30742	30743	30744	30746	30747
30880	30888	30890	30892	30893	30898	30906	30908	30910	30911	30916	30924	30925	30926	30928	30929	30936	30944	30946	30948	30949	30954	30962	30964	30966	30967	30972	30980	30981	30982	30984	30985
31118	31126	31128	31130	31131	31136	31144	31146	31148	31149	31154	31162	31163	31164	31166	31167	31174	31182	31184	31186	31187	31192	31200	31202	31204	31205	31210	31218	31219	31220	31222	31223
31356	31364	31366	31368	31369	31374	31382	31384	31386	31387	31392	31400	31401	31402	31404	31405	31412	31420	31422	31424	31425	31430	31438	31440	31442	31443	31448	31456	31457	31458	31460	31461
31594	31602	31604	31606	31607	31612	31620	31622	31624	31625	31630	31638	31639	31640	31642	31643	31650	31658	31660	31662	31663	31668	31676	31678	31680	31681	31686	31694	31695	31696	31698	31699
31832	31840	31842	31844	31845	31850	31858	31860	31862	31863	31868	31876	31877	31878	31880	31881	31888	31896	31898	31900	31901	31906	31914	31916	31918	31919	31924	31932	31933	31934	31936	31937
32070	32078	32080	32082	32083	32088	32096	32098	32100	32101	32106	32114	32115	32116	32118	32119	32126	32134	32136	32138	32139	32144	32152	32154	32156	32157	32162	32170	32171	32172	32174	32175
32308	32316	32318	32320	32321	32326	32334	32336	32338	32339	32344	32352	32353	32354	32356	32357	32364	32372	32374	32376	32377	32382	32390	32392	32394	32395	32400	32408	32409	32410	32412	32413
32546	32554	32556	32558	32559	32564	32572	32574	32576	32577	32582	32590	32591	32592	32594	32595	32602	32610	32612	32614	32615	32620	32628	32630	32632	32633	32638	32646	32647	32648	32650	32651
"]
		set Hhyd    [atomselect top "(within ${dis} of serial ${serial}) and index 30410	30418	30419	30420	30428	30436	30437	30438	30446	30454	30455	30456	30457	30466	30474	30475	30476	30484	30492	30493	30494	30502	30510	30511	30512	30513
30648	30656	30657	30658	30666	30674	30675	30676	30684	30692	30693	30694	30695	30704	30712	30713	30714	30722	30730	30731	30732	30740	30748	30749	30750	30751
30886	30894	30895	30896	30904	30912	30913	30914	30922	30930	30931	30932	30933	30942	30950	30951	30952	30960	30968	30969	30970	30978	30986	30987	30988	30989
31124	31132	31133	31134	31142	31150	31151	31152	31160	31168	31169	31170	31171	31180	31188	31189	31190	31198	31206	31207	31208	31216	31224	31225	31226	31227
31362	31370	31371	31372	31380	31388	31389	31390	31398	31406	31407	31408	31409	31418	31426	31427	31428	31436	31444	31445	31446	31454	31462	31463	31464	31465
31600	31608	31609	31610	31618	31626	31627	31628	31636	31644	31645	31646	31647	31656	31664	31665	31666	31674	31682	31683	31684	31692	31700	31701	31702	31703
31838	31846	31847	31848	31856	31864	31865	31866	31874	31882	31883	31884	31885	31894	31902	31903	31904	31912	31920	31921	31922	31930	31938	31939	31940	31941
32076	32084	32085	32086	32094	32102	32103	32104	32112	32120	32121	32122	32123	32132	32140	32141	32142	32150	32158	32159	32160	32168	32176	32177	32178	32179
32314	32322	32323	32324	32332	32340	32341	32342	32350	32358	32359	32360	32361	32370	32378	32379	32380	32388	32396	32397	32398	32406	32414	32415	32416	32417
32552	32560	32561	32562	32570	32578	32579	32580	32588	32596	32597	32598	32599	32608	32616	32617	32618	32626	32634	32635	32636	32644	32652	32653	32654	32655
"]  
		set Chyd    [atomselect top "(within ${dis} of serial ${serial}) and index 30277	30287	30289	30291	30298	30308	30310	30312	30319	30329	30330	30331	30333	30340	30350	30352	30354	30361	30371	30373	30375	30382	30392	30393	30394	30396
30515	30525	30527	30529	30536	30546	30548	30550	30557	30567	30568	30569	30571	30578	30588	30590	30592	30599	30609	30611	30613	30620	30630	30631	30632	30634
30753	30763	30765	30767	30774	30784	30786	30788	30795	30805	30806	30807	30809	30816	30826	30828	30830	30837	30847	30849	30851	30858	30868	30869	30870	30872
30991	31001	31003	31005	31012	31022	31024	31026	31033	31043	31044	31045	31047	31054	31064	31066	31068	31075	31085	31087	31089	31096	31106	31107	31108	31110
31229	31239	31241	31243	31250	31260	31262	31264	31271	31281	31282	31283	31285	31292	31302	31304	31306	31313	31323	31325	31327	31334	31344	31345	31346	31348
31467	31477	31479	31481	31488	31498	31500	31502	31509	31519	31520	31521	31523	31530	31540	31542	31544	31551	31561	31563	31565	31572	31582	31583	31584	31586
31705	31715	31717	31719	31726	31736	31738	31740	31747	31757	31758	31759	31761	31768	31778	31780	31782	31789	31799	31801	31803	31810	31820	31821	31822	31824
31943	31953	31955	31957	31964	31974	31976	31978	31985	31995	31996	31997	31999	32006	32016	32018	32020	32027	32037	32039	32041	32048	32058	32059	32060	32062
32181	32191	32193	32195	32202	32212	32214	32216	32223	32233	32234	32235	32237	32244	32254	32256	32258	32265	32275	32277	32279	32286	32296	32297	32298	32300
32419	32429	32431	32433	32440	32450	32452	32454	32461	32471	32472	32473	32475	32482	32492	32494	32496	32503	32513	32515	32517	32524	32534	32535	32536	32538
"]  
		
		set H2O     [atomselect top "(within ${dis} of serial ${serial}) and (not fragment 0 9537 to 9556) and y > ${y}"]         
		set dH2O    [atomselect top "(within ${dis} of serial ${serial}) and (not fragment 0 9537 to 9556) and y < ${y}"]  		

		set  n_Ceth   [llength [$Ceth  get serial]]
		set  n_Heth   [llength [$Heth  get serial]]
		set  n_Obr    [llength [$Obr   get serial]]
		set  n_Or     [llength [$Or    get serial]]
		set  n_Oor    [llength [$Oor   get serial]]
		set  n_Ohyd   [llength [$Ohyd  get serial]]
		set  n_Hchyd  [llength [$Hchyd get serial]]
		set  n_Hhyd   [llength [$Hhyd  get serial]]
		set  n_Chyd   [llength [$Chyd  get serial]]
		set  n_H2O    [llength [$H2O   get serial]]
		set  n_dH2O   [llength [$dH2O  get serial]]
                                                                                                                       
		if {${n_Ceth}   > 0} {set Ceth_flag  1}                                                                                      
		if {${n_Heth}   > 0} {set Heth_flag  1}                                                                                      
		if {${n_Obr}    > 0} {set Obr_flag   1}                                                                                      
		if {${n_Or}     > 0} {set Or_flag    1}                                                                                      
		if {${n_Oor}    > 0} {set Oor_flag   1}                                                                                      
		if {${n_Ohyd}   > 0} {set Ohyd_flag  1}                                                                                      
		if {${n_Hchyd}  > 0} {set Hchyd_flag 1}                                                                                      
		if {${n_Hhyd}   > 0} {set Hhyd_flag  1}                                                                                        
		if {${n_Chyd}   > 0} {set Chyd_flag  1}                                                                                    
		if {${n_H2O}    > 0} {set H2O_flag   1}                                                                                      
		if {${n_dH2O}   > 0} {set dH2O_flag  1}                                                                                               
       
		puts $outfile "$i $serial $Ceth_flag $Heth_flag $Obr_flag $Or_flag $Oor_flag $Ohyd_flag $Hchyd_flag $Hhyd_flag $Chyd_flag $H2O_flag $dH2O_flag  "  		
		$g_atom delete                                                                                                       
		$Ceth  delete
		$Heth  delete
		$Obr   delete
		$Or    delete
		$Oor   delete
		$Ohyd  delete
		$Hchyd delete
		$Hhyd  delete
		$Chyd  delete
		$H2O   delete
		$dH2O  delete                                                                                                          
	}                                                                                                                        
}                                                                                                                          
$g delete                                                                                                                  
close $outfile                                                                                                             
# exit