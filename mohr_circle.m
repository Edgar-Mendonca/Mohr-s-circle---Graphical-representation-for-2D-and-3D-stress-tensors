classdef mohr_circle < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        MohrCircleUIFigure     matlab.ui.Figure
        note                   matlab.ui.control.Label
        OuputsLabel_2          matlab.ui.control.Label
        InputsLabel_2          matlab.ui.control.Label
        OuputsLabel            matlab.ui.control.Label
        InputsLabel            matlab.ui.control.Label
        PlaneatanangleInclinedandNormalLabel  matlab.ui.control.Label
        thetaN                 matlab.ui.control.NumericEditField
        nLabel                 matlab.ui.control.Label
        Nor                    matlab.ui.control.CheckBox
        Ang                    matlab.ui.control.CheckBox
        WEBMANUALButton        matlab.ui.control.Button
        phi                    matlab.ui.control.NumericEditField
        Label_13               matlab.ui.control.Label
        rE                     matlab.ui.control.NumericEditField
        rEditFieldLabel        matlab.ui.control.Label
        tE                     matlab.ui.control.NumericEditField
        tEditFieldLabel        matlab.ui.control.Label
        nE                     matlab.ui.control.NumericEditField
        nEditFieldLabel        matlab.ui.control.Label
        thetaA                 matlab.ui.control.NumericEditField
        aLabel                 matlab.ui.control.Label
        thi2                   matlab.ui.control.NumericEditField
        Label_15               matlab.ui.control.Label
        thi1                   matlab.ui.control.NumericEditField
        Label_14               matlab.ui.control.Label
        ShearPlanesLabel       matlab.ui.control.Label
        DMOHRCIRCLECheckBox_2  matlab.ui.control.CheckBox
        DMOHRCIRCLECheckBox    matlab.ui.control.CheckBox
        PrincipalPlanesLabel   matlab.ui.control.Label
        EdgarMendoncaLabel     matlab.ui.control.Label
        th2                    matlab.ui.control.NumericEditField
        Label_8                matlab.ui.control.Label
        th1                    matlab.ui.control.NumericEditField
        Label_7                matlab.ui.control.Label
        RESETButton            matlab.ui.control.Button
        T3                     matlab.ui.control.NumericEditField
        Label_6                matlab.ui.control.Label
        T2                     matlab.ui.control.NumericEditField
        Label_5                matlab.ui.control.Label
        T1                     matlab.ui.control.NumericEditField
        Label_4                matlab.ui.control.Label
        SS3                    matlab.ui.control.NumericEditField
        Label_11               matlab.ui.control.Label
        SS2                    matlab.ui.control.NumericEditField
        Label_10               matlab.ui.control.Label
        SS1                    matlab.ui.control.NumericEditField
        Label_9                matlab.ui.control.Label
        CALCULATE3DButton      matlab.ui.control.Button
        TZX                    matlab.ui.control.NumericEditField
        zxLabel                matlab.ui.control.Label
        TYZ                    matlab.ui.control.NumericEditField
        yzLabel                matlab.ui.control.Label
        TXY                    matlab.ui.control.NumericEditField
        xyLabel_2              matlab.ui.control.Label
        SSZ                    matlab.ui.control.NumericEditField
        zLabel                 matlab.ui.control.Label
        SSY                    matlab.ui.control.NumericEditField
        yLabel_2               matlab.ui.control.Label
        SSX                    matlab.ui.control.NumericEditField
        xLabel_2               matlab.ui.control.Label
        T                      matlab.ui.control.NumericEditField
        Label_3                matlab.ui.control.Label
        S2                     matlab.ui.control.NumericEditField
        Label                  matlab.ui.control.Label
        S1                     matlab.ui.control.NumericEditField
        Label_2                matlab.ui.control.Label
        CALCULATE2DButton      matlab.ui.control.Button
        Txy                    matlab.ui.control.NumericEditField
        xyLabel                matlab.ui.control.Label
        Sy                     matlab.ui.control.NumericEditField
        yLabel                 matlab.ui.control.Label
        Sx                     matlab.ui.control.NumericEditField
        xLabel                 matlab.ui.control.Label
        MOHRSCIRCLELabel       matlab.ui.control.Label
        UIAxes                 matlab.ui.control.UIAxes
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: CALCULATE2DButton
        function CALCULATE2DButtonPushed(app, event)
            sx = app.Sx.Value;
            sy= app.Sy.Value;
            txy = app.Txy.Value;
            
            app.T.Value = sqrt(((sx-sy)/2)^2 + txy^2);
            t = app.T.Value;
            
          
            c = (sx+sy)/2;
            th = 0:0.1:2*pi*t;
            
            x = t*cos(th) + c;
            y = t*sin(th);
            
            
            
            
            app.S1.Value = max(x);
            app.S2.Value = min(x);
            
            app.th1.Value = 0.5*atand((2*txy)/(sx-sy));
            app.th2.Value = 90 + app.th1.Value;
            
           t1 = app.th1.Value;
           app.thi1.Value = 45+t1;
           app.thi2.Value = 135+t1;
           
           plot(app.UIAxes,x,y);
            hold(app.UIAxes, 'on');
            plot(app.UIAxes, [min(x),max(x)], [0,0]);

            plot(app.UIAxes, [c,c],[-t,t]);

            plot(app.UIAxes,[sx,sy],[-txy,txy]);
            
            axis(app.UIAxes, 'equal');
            
            
       
  
        end

        % Button pushed function: CALCULATE3DButton
        function CALCULATE3DButtonPushed(app, event)
            sSX=app.SSX.Value;
            sSY=app.SSY.Value;
            sSZ=app.SSZ.Value;
            tXY=app.TXY.Value;
            tYZ=app.TYZ.Value;
            tZX=app.TZX.Value;
            
            I1=sSX+sSY+sSZ;
            I2=(sSX*sSY)+(sSY*sSZ)+(sSZ*sSX)-(tXY^2)-(tYZ^2)-(tZX^2);
            I3=(sSX*sSY*sSZ)+(2*tXY*tYZ*tZX)-(sSX*(tYZ^2))-(sSY*(tZX^2))-(sSZ*(tXY^2));
            
            p = [1 -I1 I2 -I3];
            r = roots(p);
            sS1=r(1,1);
            sS2=r(2,1);
            sS3=r(3,1);
            
            t1=(sS1-sS3)/2;
            t2=(sS1-sS2)/2;
            t3=(sS2-sS3)/2;
            
            app.T1.Value=t1;
            app.T2.Value=t2;
            app.T3.Value=t3;
            
            app.SS1.Value=sS1;
            app.SS2.Value=sS2;
            app.SS3.Value=sS3;
            
            th = 0:0.1:2*pi*100;
            C1 = (sS1+sS3)/2;
            C2 = (sS1+sS2)/2;
            C3 = (sS2+sS3)/2;
            
            x1=t1*cos(th) + C1;
            y1=t1*sin(th);
            
            x2=t2*cos(th) + C2;
            y2=t2*sin(th);
            
            x3=t3*cos(th) + C3;
            y3=t3*sin(th);
            
            plot(app.UIAxes,x1,y1);
            hold(app.UIAxes,'on');
            plot(app.UIAxes,x2,y2);
            hold(app.UIAxes,'on');
            plot(app.UIAxes,x3,y3);
            
            
            axis(app.UIAxes, 'equal');

           
           
            
        end

        % Button pushed function: RESETButton
        function RESETButtonPushed(app, event)
            app.Sx.Value=0;
            app.Sy.Value=0;
            app.Txy.Value=0;
            app.S1.Value = 0;
            app.S2.Value = 0;
            app.T.Value = 0;
            app.th1.Value = 0;
            app.th2.Value = 0;
            app.thi1.Value = 0;
            app.thi2.Value = 0;
            
            hold(app.UIAxes, 'off');
            
            app.SSX.Value=0;
            app.SSY.Value=0;
            app.SSZ.Value=0;
            app.TXY.Value=0;
            app.TYZ.Value=0;
            app.TZX.Value=0;
            app.T1.Value=0;
            app.T2.Value=0;
            app.T3.Value=0;
            
            app.SS1.Value=0;
            app.SS2.Value=0;
            app.SS3.Value=0;
            
            app.DMOHRCIRCLECheckBox.Value=0;
            app.SSX.Editable = 'on';
                app.SSY.Editable = 'on';
                app.SSZ.Editable = 'on';
                app.TXY.Editable = 'on';
                app.TYZ.Editable = 'on';
                app.TZX.Editable = 'on';
                
                app.SS1.Editable = 'on';
                app.SS2.Editable = 'on';
                app.SS3.Editable = 'on';
                app.T1.Editable = 'on';
                app.T2.Editable = 'on';
                app.T3.Editable = 'on';
                
                app.DMOHRCIRCLECheckBox_2.Value=0;
                app.Sx.Editable = 'on';
                app.Sy.Editable = 'on';
                app.Txy.Editable ='on';
                app.S1.Editable = 'on';
                app.S2.Editable = 'on';
                app.T.Editable = 'on';
                
                app.th1.Editable = 'on';
                app.th2.Editable = 'on';
                app.thi1.Editable = 'on';
                app.thi2.Editable = 'on';
                
                
                app.thetaA.Editable = 'on';
                app.thetaN.Editable = 'on';
                
                app.thetaA.Value = 0;
                app.thetaN.Value = 0;
                
                app.Ang.Value = 0;
                app.Nor.Value = 0;
                
                app.nE.Value = 0;
                app.tE.Value = 0;
                app.rE.Value = 0;
                app.phi.Value = 0;
                
            cla(app.UIAxes)
            
        end

        % Value changed function: DMOHRCIRCLECheckBox
        function DMOHRCIRCLECheckBoxValueChanged(app, event)
            value = app.DMOHRCIRCLECheckBox.Value;
            
            app.DMOHRCIRCLECheckBox.Value=0;
            app.DMOHRCIRCLECheckBox.Value=1;
            
            if app.DMOHRCIRCLECheckBox.Value == 1
                app.SSX.Editable = 'off';
                app.SSY.Editable = 'off';
                app.SSZ.Editable = 'off';
                app.TXY.Editable = 'off';
                app.TYZ.Editable = 'off';
                app.TZX.Editable = 'off';
                
                app.SS1.Editable = 'off';
                app.SS2.Editable = 'off';
                app.SS3.Editable = 'off';
                app.T1.Editable = 'off';
                app.T2.Editable = 'off';
                app.T3.Editable = 'off';
            end
        end

        % Value changed function: DMOHRCIRCLECheckBox_2
        function DMOHRCIRCLECheckBox_2ValueChanged(app, event)
            value = app.DMOHRCIRCLECheckBox_2.Value;
            
            app.DMOHRCIRCLECheckBox_2.Value=0;
            app.DMOHRCIRCLECheckBox_2.Value=1;
            
            if  app.DMOHRCIRCLECheckBox_2.Value == 1
                app.Sx.Editable = 'off';
                app.Sy.Editable = 'off';
                app.Txy.Editable = 'off';
                app.S1.Editable = 'off';
                app.S2.Editable = 'off';
                app.T.Editable = 'off';
                
                app.th1.Editable = 'off';
                app.th2.Editable = 'off';
                app.thi1.Editable = 'off';
                app.thi2.Editable = 'off';
            end
        end

        % Button pushed function: WEBMANUALButton
        function WEBMANUALButtonPushed(app, event)
            web('https://sites.google.com/view/edgarmendonca/softwares-and-codes/solution-for-mohrs-circle')
        end

        % Value changed function: Ang
        function AngValueChanged(app, event)
            value = app.Ang.Value;
            
            app.Ang.Value = 0;
            app.Ang.Value = 1;
            
        if app.Ang.Value == 1
            app.thetaN.Editable = 'off';
            te = app.thetaA.Value;
            sx=app.Sx.Value;
            sy=app.Sy.Value;
            
            tuxy = app.Txy.Value;
            
            app.nE.Value = ((sx+sy)/2)+(((sx-sy)/2)*cosd(2*te))+(tuxy*sind(2*te));
            n = app.nE.Value;
            app.tE.Value = -(((sx-sy)/2)*sind(2*te))+(tuxy*cosd(2*te));
            t = app.tE.Value;
            app.rE.Value = sqrt((n^2)+(t^2));
            app.phi.Value = atand(t/n);  
        end
        end

        % Value changed function: Nor
        function NorValueChanged(app, event)
            value = app.Nor.Value;
            
            app.Nor.Value = 0;
            app.Nor.Value = 1;
            
            if app.Nor.Value == 1
                app.thetaA.Editable = 'off';
                t = app.thetaN.Value
                te = 90-t;
                s1=app.S1.Value;
                s2=app.S2.Value;
                tuxy = app.Txy.Value;
                
                app.nE.Value = ((sx+sy)/2)+(((sx-sy)/2)*cosd(2*te))+(tuxy*sind(2*te));
                n = app.nE.Value;
                app.tE.Value = -(((sx-sy)/2)*sind(2*te))+(tuxy*cosd(2*te));
                t = app.tE.Value;
                app.rE.Value = sqrt((n^2)+(t^2));
                app.phi.Value = atand(t/n); 
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create MohrCircleUIFigure and hide until all components are created
            app.MohrCircleUIFigure = uifigure('Visible', 'off');
            app.MohrCircleUIFigure.Color = [0.9412 0.9412 0.9412];
            app.MohrCircleUIFigure.Position = [100 100 1143 612];
            app.MohrCircleUIFigure.Name = 'Mohr Circle';
            app.MohrCircleUIFigure.Resize = 'off';

            % Create UIAxes
            app.UIAxes = uiaxes(app.MohrCircleUIFigure);
            title(app.UIAxes, 'Shear Stress v/s Normal Stress')
            xlabel(app.UIAxes, '\sigma (N/mm^2)')
            ylabel(app.UIAxes, '\tau (N/mm^2)')
            app.UIAxes.PlotBoxAspectRatio = [1.65142857142857 1 1];
            app.UIAxes.FontName = 'Cambria Math';
            app.UIAxes.FontWeight = 'bold';
            app.UIAxes.XGrid = 'on';
            app.UIAxes.YGrid = 'on';
            app.UIAxes.Box = 'on';
            app.UIAxes.Position = [9 189 456 350];

            % Create MOHRSCIRCLELabel
            app.MOHRSCIRCLELabel = uilabel(app.MohrCircleUIFigure);
            app.MOHRSCIRCLELabel.HorizontalAlignment = 'center';
            app.MOHRSCIRCLELabel.FontName = 'Cambria Math';
            app.MOHRSCIRCLELabel.FontSize = 25;
            app.MOHRSCIRCLELabel.FontWeight = 'bold';
            app.MOHRSCIRCLELabel.Position = [481 569 183 30];
            app.MOHRSCIRCLELabel.Text = 'MOHR''S CIRCLE';

            % Create xLabel
            app.xLabel = uilabel(app.MohrCircleUIFigure);
            app.xLabel.HorizontalAlignment = 'right';
            app.xLabel.Position = [486 458 25 22];
            app.xLabel.Text = 'σx';

            % Create Sx
            app.Sx = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.Sx.Position = [526 458 100 22];

            % Create yLabel
            app.yLabel = uilabel(app.MohrCircleUIFigure);
            app.yLabel.HorizontalAlignment = 'right';
            app.yLabel.Position = [486 426 25 22];
            app.yLabel.Text = 'σy';

            % Create Sy
            app.Sy = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.Sy.Position = [526 426 100 22];

            % Create xyLabel
            app.xyLabel = uilabel(app.MohrCircleUIFigure);
            app.xyLabel.HorizontalAlignment = 'right';
            app.xyLabel.Position = [486 394 25 22];
            app.xyLabel.Text = '𝜏xy';

            % Create Txy
            app.Txy = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.Txy.Position = [526 394 100 22];

            % Create CALCULATE2DButton
            app.CALCULATE2DButton = uibutton(app.MohrCircleUIFigure, 'push');
            app.CALCULATE2DButton.ButtonPushedFcn = createCallbackFcn(app, @CALCULATE2DButtonPushed, true);
            app.CALCULATE2DButton.BackgroundColor = [0.8 0.8 0.8];
            app.CALCULATE2DButton.FontName = 'Cambria Math';
            app.CALCULATE2DButton.FontSize = 14;
            app.CALCULATE2DButton.FontWeight = 'bold';
            app.CALCULATE2DButton.Position = [584 352 114 24];
            app.CALCULATE2DButton.Text = 'CALCULATE 2D ';

            % Create Label_2
            app.Label_2 = uilabel(app.MohrCircleUIFigure);
            app.Label_2.HorizontalAlignment = 'right';
            app.Label_2.FontWeight = 'bold';
            app.Label_2.Position = [646 459 25 22];
            app.Label_2.Text = 'σ1';

            % Create S1
            app.S1 = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.S1.FontWeight = 'bold';
            app.S1.Position = [686 459 100 22];

            % Create Label
            app.Label = uilabel(app.MohrCircleUIFigure);
            app.Label.HorizontalAlignment = 'right';
            app.Label.FontWeight = 'bold';
            app.Label.Position = [646 426 25 22];
            app.Label.Text = 'σ2';

            % Create S2
            app.S2 = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.S2.FontWeight = 'bold';
            app.S2.Position = [686 426 100 22];

            % Create Label_3
            app.Label_3 = uilabel(app.MohrCircleUIFigure);
            app.Label_3.HorizontalAlignment = 'right';
            app.Label_3.FontWeight = 'bold';
            app.Label_3.Position = [646 394 25 22];
            app.Label_3.Text = '𝜏';

            % Create T
            app.T = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.T.FontWeight = 'bold';
            app.T.Position = [686 394 100 22];

            % Create xLabel_2
            app.xLabel_2 = uilabel(app.MohrCircleUIFigure);
            app.xLabel_2.HorizontalAlignment = 'center';
            app.xLabel_2.Position = [839 458 25 22];
            app.xLabel_2.Text = 'σx';

            % Create SSX
            app.SSX = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.SSX.Position = [879 458 100 22];

            % Create yLabel_2
            app.yLabel_2 = uilabel(app.MohrCircleUIFigure);
            app.yLabel_2.HorizontalAlignment = 'center';
            app.yLabel_2.Position = [839 426 25 22];
            app.yLabel_2.Text = 'σy';

            % Create SSY
            app.SSY = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.SSY.Position = [879 426 100 22];

            % Create zLabel
            app.zLabel = uilabel(app.MohrCircleUIFigure);
            app.zLabel.HorizontalAlignment = 'center';
            app.zLabel.Position = [840 394 25 22];
            app.zLabel.Text = 'σz';

            % Create SSZ
            app.SSZ = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.SSZ.Position = [880 394 100 22];

            % Create xyLabel_2
            app.xyLabel_2 = uilabel(app.MohrCircleUIFigure);
            app.xyLabel_2.HorizontalAlignment = 'center';
            app.xyLabel_2.Position = [992 458 25 22];
            app.xyLabel_2.Text = '𝜏xy';

            % Create TXY
            app.TXY = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.TXY.Position = [1032 458 100 22];

            % Create yzLabel
            app.yzLabel = uilabel(app.MohrCircleUIFigure);
            app.yzLabel.HorizontalAlignment = 'center';
            app.yzLabel.Position = [992 426 25 22];
            app.yzLabel.Text = '𝜏yz';

            % Create TYZ
            app.TYZ = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.TYZ.Position = [1032 426 100 22];

            % Create zxLabel
            app.zxLabel = uilabel(app.MohrCircleUIFigure);
            app.zxLabel.HorizontalAlignment = 'center';
            app.zxLabel.Position = [992 394 25 22];
            app.zxLabel.Text = '𝜏zx';

            % Create TZX
            app.TZX = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.TZX.Position = [1032 394 100 22];

            % Create CALCULATE3DButton
            app.CALCULATE3DButton = uibutton(app.MohrCircleUIFigure, 'push');
            app.CALCULATE3DButton.ButtonPushedFcn = createCallbackFcn(app, @CALCULATE3DButtonPushed, true);
            app.CALCULATE3DButton.BackgroundColor = [0.8 0.8 0.8];
            app.CALCULATE3DButton.FontName = 'Cambria Math';
            app.CALCULATE3DButton.FontSize = 14;
            app.CALCULATE3DButton.FontWeight = 'bold';
            app.CALCULATE3DButton.Position = [949 352 111 24];
            app.CALCULATE3DButton.Text = 'CALCULATE 3D';

            % Create Label_9
            app.Label_9 = uilabel(app.MohrCircleUIFigure);
            app.Label_9.HorizontalAlignment = 'center';
            app.Label_9.FontWeight = 'bold';
            app.Label_9.Position = [843 304 25 22];
            app.Label_9.Text = 'σ1';

            % Create SS1
            app.SS1 = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.SS1.FontWeight = 'bold';
            app.SS1.Position = [883 304 100 22];

            % Create Label_10
            app.Label_10 = uilabel(app.MohrCircleUIFigure);
            app.Label_10.HorizontalAlignment = 'center';
            app.Label_10.FontWeight = 'bold';
            app.Label_10.Position = [843 274 25 22];
            app.Label_10.Text = 'σ2';

            % Create SS2
            app.SS2 = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.SS2.FontWeight = 'bold';
            app.SS2.Position = [883 274 100 22];

            % Create Label_11
            app.Label_11 = uilabel(app.MohrCircleUIFigure);
            app.Label_11.HorizontalAlignment = 'center';
            app.Label_11.FontWeight = 'bold';
            app.Label_11.Position = [843 244 25 22];
            app.Label_11.Text = 'σ3';

            % Create SS3
            app.SS3 = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.SS3.FontWeight = 'bold';
            app.SS3.Position = [883 244 100 22];

            % Create Label_4
            app.Label_4 = uilabel(app.MohrCircleUIFigure);
            app.Label_4.HorizontalAlignment = 'center';
            app.Label_4.FontWeight = 'bold';
            app.Label_4.Position = [992 304 25 22];
            app.Label_4.Text = '𝜏1';

            % Create T1
            app.T1 = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.T1.FontWeight = 'bold';
            app.T1.Position = [1032 304 100 22];

            % Create Label_5
            app.Label_5 = uilabel(app.MohrCircleUIFigure);
            app.Label_5.HorizontalAlignment = 'center';
            app.Label_5.FontWeight = 'bold';
            app.Label_5.Position = [992 274 25 22];
            app.Label_5.Text = '𝜏2';

            % Create T2
            app.T2 = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.T2.FontWeight = 'bold';
            app.T2.Position = [1032 274 100 22];

            % Create Label_6
            app.Label_6 = uilabel(app.MohrCircleUIFigure);
            app.Label_6.HorizontalAlignment = 'center';
            app.Label_6.FontWeight = 'bold';
            app.Label_6.Position = [992 244 25 22];
            app.Label_6.Text = '𝜏3';

            % Create T3
            app.T3 = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.T3.FontWeight = 'bold';
            app.T3.Position = [1032 244 100 22];

            % Create RESETButton
            app.RESETButton = uibutton(app.MohrCircleUIFigure, 'push');
            app.RESETButton.ButtonPushedFcn = createCallbackFcn(app, @RESETButtonPushed, true);
            app.RESETButton.BackgroundColor = [0.9294 0.6902 0.1294];
            app.RESETButton.FontName = 'Cambria Math';
            app.RESETButton.FontSize = 14;
            app.RESETButton.FontWeight = 'bold';
            app.RESETButton.Position = [162 125 100 24];
            app.RESETButton.Text = 'RESET';

            % Create Label_7
            app.Label_7 = uilabel(app.MohrCircleUIFigure);
            app.Label_7.HorizontalAlignment = 'right';
            app.Label_7.FontWeight = 'bold';
            app.Label_7.Position = [483 299 25 22];
            app.Label_7.Text = 'θ1';

            % Create th1
            app.th1 = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.th1.FontWeight = 'bold';
            app.th1.Position = [527 299 100 22];

            % Create Label_8
            app.Label_8 = uilabel(app.MohrCircleUIFigure);
            app.Label_8.HorizontalAlignment = 'right';
            app.Label_8.FontWeight = 'bold';
            app.Label_8.Position = [483 274 25 22];
            app.Label_8.Text = 'θ2';

            % Create th2
            app.th2 = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.th2.FontWeight = 'bold';
            app.th2.Position = [527 274 100 22];

            % Create EdgarMendoncaLabel
            app.EdgarMendoncaLabel = uilabel(app.MohrCircleUIFigure);
            app.EdgarMendoncaLabel.FontWeight = 'bold';
            app.EdgarMendoncaLabel.Position = [1021 8 111 22];
            app.EdgarMendoncaLabel.Text = '©Edgar Mendonca';

            % Create PrincipalPlanesLabel
            app.PrincipalPlanesLabel = uilabel(app.MohrCircleUIFigure);
            app.PrincipalPlanesLabel.FontWeight = 'bold';
            app.PrincipalPlanesLabel.Position = [506 325 98 22];
            app.PrincipalPlanesLabel.Text = 'Principal Planes';

            % Create DMOHRCIRCLECheckBox
            app.DMOHRCIRCLECheckBox = uicheckbox(app.MohrCircleUIFigure);
            app.DMOHRCIRCLECheckBox.ValueChangedFcn = createCallbackFcn(app, @DMOHRCIRCLECheckBoxValueChanged, true);
            app.DMOHRCIRCLECheckBox.Text = '2D MOHR CIRCLE';
            app.DMOHRCIRCLECheckBox.FontSize = 14;
            app.DMOHRCIRCLECheckBox.FontWeight = 'bold';
            app.DMOHRCIRCLECheckBox.Position = [587 517 143 22];

            % Create DMOHRCIRCLECheckBox_2
            app.DMOHRCIRCLECheckBox_2 = uicheckbox(app.MohrCircleUIFigure);
            app.DMOHRCIRCLECheckBox_2.ValueChangedFcn = createCallbackFcn(app, @DMOHRCIRCLECheckBox_2ValueChanged, true);
            app.DMOHRCIRCLECheckBox_2.Text = '3D MOHR CIRCLE';
            app.DMOHRCIRCLECheckBox_2.FontSize = 14;
            app.DMOHRCIRCLECheckBox_2.FontWeight = 'bold';
            app.DMOHRCIRCLECheckBox_2.Position = [933 517 143 22];

            % Create ShearPlanesLabel
            app.ShearPlanesLabel = uilabel(app.MohrCircleUIFigure);
            app.ShearPlanesLabel.FontWeight = 'bold';
            app.ShearPlanesLabel.Position = [670 325 81 22];
            app.ShearPlanesLabel.Text = 'Shear Planes';

            % Create Label_14
            app.Label_14 = uilabel(app.MohrCircleUIFigure);
            app.Label_14.HorizontalAlignment = 'right';
            app.Label_14.FontWeight = 'bold';
            app.Label_14.Position = [646 301 25 22];
            app.Label_14.Text = 'θ1''';

            % Create thi1
            app.thi1 = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.thi1.FontWeight = 'bold';
            app.thi1.Position = [686 301 100 22];

            % Create Label_15
            app.Label_15 = uilabel(app.MohrCircleUIFigure);
            app.Label_15.HorizontalAlignment = 'right';
            app.Label_15.FontWeight = 'bold';
            app.Label_15.Position = [646 274 25 22];
            app.Label_15.Text = 'θ2''';

            % Create thi2
            app.thi2 = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.thi2.FontWeight = 'bold';
            app.thi2.Position = [686 274 100 22];

            % Create aLabel
            app.aLabel = uilabel(app.MohrCircleUIFigure);
            app.aLabel.HorizontalAlignment = 'right';
            app.aLabel.FontWeight = 'bold';
            app.aLabel.Position = [489 208 25 22];
            app.aLabel.Text = ' θa';

            % Create thetaA
            app.thetaA = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.thetaA.FontWeight = 'bold';
            app.thetaA.Position = [529 208 100 22];

            % Create nEditFieldLabel
            app.nEditFieldLabel = uilabel(app.MohrCircleUIFigure);
            app.nEditFieldLabel.HorizontalAlignment = 'right';
            app.nEditFieldLabel.FontWeight = 'bold';
            app.nEditFieldLabel.Position = [646 208 25 22];
            app.nEditFieldLabel.Text = 'σn';

            % Create nE
            app.nE = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.nE.FontWeight = 'bold';
            app.nE.Position = [686 208 100 22];

            % Create tEditFieldLabel
            app.tEditFieldLabel = uilabel(app.MohrCircleUIFigure);
            app.tEditFieldLabel.HorizontalAlignment = 'right';
            app.tEditFieldLabel.FontWeight = 'bold';
            app.tEditFieldLabel.Position = [646 176 25 22];
            app.tEditFieldLabel.Text = 'σt';

            % Create tE
            app.tE = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.tE.FontWeight = 'bold';
            app.tE.Position = [686 176 100 22];

            % Create rEditFieldLabel
            app.rEditFieldLabel = uilabel(app.MohrCircleUIFigure);
            app.rEditFieldLabel.HorizontalAlignment = 'right';
            app.rEditFieldLabel.FontWeight = 'bold';
            app.rEditFieldLabel.Position = [646 144 25 22];
            app.rEditFieldLabel.Text = 'σr';

            % Create rE
            app.rE = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.rE.FontWeight = 'bold';
            app.rE.Position = [686 144 100 22];

            % Create Label_13
            app.Label_13 = uilabel(app.MohrCircleUIFigure);
            app.Label_13.HorizontalAlignment = 'right';
            app.Label_13.FontWeight = 'bold';
            app.Label_13.Position = [646 112 25 22];
            app.Label_13.Text = 'Φ';

            % Create phi
            app.phi = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.phi.FontWeight = 'bold';
            app.phi.Position = [686 112 100 22];

            % Create WEBMANUALButton
            app.WEBMANUALButton = uibutton(app.MohrCircleUIFigure, 'push');
            app.WEBMANUALButton.ButtonPushedFcn = createCallbackFcn(app, @WEBMANUALButtonPushed, true);
            app.WEBMANUALButton.BackgroundColor = [0.851 0.3255 0.098];
            app.WEBMANUALButton.FontName = 'Cambria Math';
            app.WEBMANUALButton.FontSize = 14;
            app.WEBMANUALButton.FontWeight = 'bold';
            app.WEBMANUALButton.Position = [24 124 118 26];
            app.WEBMANUALButton.Text = 'WEB/MANUAL';

            % Create Ang
            app.Ang = uicheckbox(app.MohrCircleUIFigure);
            app.Ang.ValueChangedFcn = createCallbackFcn(app, @AngValueChanged, true);
            app.Ang.Text = '';
            app.Ang.Position = [472 208 18 22];

            % Create Nor
            app.Nor = uicheckbox(app.MohrCircleUIFigure);
            app.Nor.ValueChangedFcn = createCallbackFcn(app, @NorValueChanged, true);
            app.Nor.Text = '';
            app.Nor.Position = [472 179 18 22];

            % Create nLabel
            app.nLabel = uilabel(app.MohrCircleUIFigure);
            app.nLabel.HorizontalAlignment = 'right';
            app.nLabel.FontWeight = 'bold';
            app.nLabel.Position = [489 179 25 22];
            app.nLabel.Text = ' θn';

            % Create thetaN
            app.thetaN = uieditfield(app.MohrCircleUIFigure, 'numeric');
            app.thetaN.FontWeight = 'bold';
            app.thetaN.Position = [529 179 100 22];

            % Create PlaneatanangleInclinedandNormalLabel
            app.PlaneatanangleInclinedandNormalLabel = uilabel(app.MohrCircleUIFigure);
            app.PlaneatanangleInclinedandNormalLabel.FontWeight = 'bold';
            app.PlaneatanangleInclinedandNormalLabel.Position = [553 241 232 22];
            app.PlaneatanangleInclinedandNormalLabel.Text = 'Plane at an angle (Inclined and Normal)';

            % Create InputsLabel
            app.InputsLabel = uilabel(app.MohrCircleUIFigure);
            app.InputsLabel.FontWeight = 'bold';
            app.InputsLabel.Position = [533 479 41 22];
            app.InputsLabel.Text = 'Inputs';

            % Create OuputsLabel
            app.OuputsLabel = uilabel(app.MohrCircleUIFigure);
            app.OuputsLabel.FontWeight = 'bold';
            app.OuputsLabel.Position = [712 480 47 22];
            app.OuputsLabel.Text = 'Ouputs';

            % Create InputsLabel_2
            app.InputsLabel_2 = uilabel(app.MohrCircleUIFigure);
            app.InputsLabel_2.FontWeight = 'bold';
            app.InputsLabel_2.Position = [965 479 41 22];
            app.InputsLabel_2.Text = 'Inputs';

            % Create OuputsLabel_2
            app.OuputsLabel_2 = uilabel(app.MohrCircleUIFigure);
            app.OuputsLabel_2.FontWeight = 'bold';
            app.OuputsLabel_2.Position = [978 325 47 22];
            app.OuputsLabel_2.Text = 'Ouputs';

            % Create note
            app.note = uilabel(app.MohrCircleUIFigure);
            app.note.HorizontalAlignment = 'center';
            app.note.FontSize = 10;
            app.note.FontWeight = 'bold';
            app.note.Position = [5 8 371 22];
            app.note.Text = 'NOTE: All units to be maintained in one standard system (SI)';

            % Show the figure after all components are created
            app.MohrCircleUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = mohr_circle

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.MohrCircleUIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.MohrCircleUIFigure)
        end
    end
end